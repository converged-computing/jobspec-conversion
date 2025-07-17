#!/bin/bash
#FLUX: --job-name=maskrcnn_mlpv21
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=mlperf
#FLUX: -t=21600
#FLUX: --urgency=16

export WORLD_SIZE='${SLURM_NPROCS}'
export RANK='$((${DGXNGPU}*${SLURM_NODEID}+${SLURM_LOCALID}))'
export MASTER_ADDR='${SLURMD_NODENAME}'
export MASTER_PORT='5678'
export LOGDIR='${LOGDIR}/${SLURM_JOB_ID}'

set -eux
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${MLPERF_RULESET:=2.1.0}"
: "${NEXP:=5}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${WORK_DIR:=/workspace/object_detection}"
: "${LOGDIR:=./results}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
export WORLD_SIZE=${SLURM_NPROCS}
export RANK=$((${DGXNGPU}*${SLURM_NODEID}+${SLURM_LOCALID}))
export MASTER_ADDR=${SLURMD_NODENAME}
export MASTER_PORT=5678
echo "[HPE] setting distributed info WORLD_SIZE=$WORLD_SIZE, MASTER_ADDR=$MASTER_ADDR MASTER_PORT=$MASTER_PORT"
LOGBASE="${DATESTAMP}"
TIME_TAGS=${TIME_TAGS:-0}
NVTX_FLAG=${NVTX_FLAG:-0}
NCCL_TEST=${NCCL_TEST:-0}
SYNTH_DATA=${SYNTH_DATA:-0}
EPOCH_PROF=${EPOCH_PROF:-0}
DISABLE_CG=${DISABLE_CG:-0}
SPREFIX="object_detection_pytorch_${DGXNNODES}x${DGXNGPU}x${BATCHSIZE}_${DATESTAMP}"
if [ ${TIME_TAGS} -gt 0 ]; then
    LOGBASE="${SPREFIX}_mllog"
fi
if [ ${NVTX_FLAG} -gt 0 ]; then
    if [[ "$LOGBASE" == *'_'* ]];then
        LOGBASE="${LOGBASE}_nsys"
    else
        LOGBASE="${SPREFIX}_nsys"
    fi
    if [[ ! -d "${NVMLPERF_NSIGHT_LOCATION}" ]]; then
	echo "$NVMLPERF_NSIGHT_LOCATION doesn't exist on this system!" 1>&2
	exit 1
    fi
fi
if [ ${SYNTH_DATA} -gt 0 ]; then
    if [[ "$LOGBASE" == *'_'* ]];then
        LOGBASE="${LOGBASE}_synth"
    else
        LOGBASE="${SPREFIX}_synth"
    fi
fi
if [ ${EPOCH_PROF} -gt 0 ]; then
    if [[ "$LOGBASE" == *'_'* ]];then
        LOGBASE="${LOGBASE}_epoch"
    else
        LOGBASE="${SPREFIX}_epoch"
    fi
fi
if [ ${DISABLE_CG} -gt 0 ]; then
    EXTRA_CONFIG=$(echo $EXTRA_CONFIG | sed 's/USE_CUDA_GRAPH\sTrue/USE_CUDA_GRAPH False/')
    if [[ "$LOGBASE" == *'_'* ]];then
        LOGBASE="${LOGBASE}_nocg"
    else
        LOGBASE="${SPREFIX}_nocg"
    fi
fi
export LOGDIR="${LOGDIR}/${SLURM_JOB_ID}"
mkdir -p ${LOGDIR}
func_get_container_mounts() {
  declare -a mount_array
  readarray -t mount_array <<<$(egrep -v '^#' "${1}")
  local cont_mounts=$(envsubst <<< $(printf '%s,' "${mount_array[@]}" | sed 's/[,]*$//'))
  echo $cont_mounts
}
func_update_file_path_for_ci() {
  declare new_path
  if [ -f "${1}" ]; then
    new_path="${1}"
  else
    new_path="${2}/${1}"
  fi
  if [ ! -f "${new_path}" ]; then
    echo "File not found: ${1}"
    exit 1
  fi
  echo "${new_path}"
}
_cont_mounts=$(func_get_container_mounts $(func_update_file_path_for_ci mounts.txt ${PWD}))
readonly _logfile_base="${LOGDIR}/${LOGBASE}"
readonly _cont_name=object_detection
_cont_mounts+=",${DATADIR}:/data,${PKLPATH}:/pkl_coco,${LOGDIR}:/results"
_cont_mounts+=",${PWD}:${WORK_DIR}"
if [[ "${NVTX_FLAG}" -gt 0 ]]; then
    _cont_mounts+=",${NVMLPERF_NSIGHT_LOCATION}:/nsight"
fi
if [ "${API_LOGGING:-}" -eq 1 ]; then
    _cont_mounts+=",${API_LOG_DIR}:/logs"
fi
echo MELLANOX_VISIBLE_DEVICES="${MELLANOX_VISIBLE_DEVICES:-}"
srun \
    --ntasks="${SLURM_JOB_NUM_NODES}" \
    --container-image="${CONT}" \
    --container-name="${_cont_name}" \
    --container-mounts="${_cont_mounts}" true
    true
for _experiment_index in $(seq -w 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
        echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST}"
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun \
                --ntasks="${SLURM_JOB_NUM_NODES}" \
                --container-mounts="${_cont_mounts}" \
                --container-name="${_cont_name}" \
                python ${WORK_DIR}/drop.py 
        fi
        # Run experiment
        srun \
            --mpi=none \
            --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" \
            --ntasks-per-node="${DGXNGPU}" \
            --container-name="${_cont_name}" \
            --container-mounts="${_cont_mounts}" \
            ./run_and_time.sh
    ) |& tee "${_logfile_base}_${_experiment_index}.log"
    # # compliance checker
    # srun --ntasks=1 --nodes=1 --container-name="${_cont_name}" \
    #      --container-mounts="$(realpath ${LOGDIR}):/results"   \
    #      --container-workdir="/results"                        \
    #      python3 -m mlperf_logging.compliance_checker --usage training \
    #      --ruleset "${MLPERF_RULESET}"                                 \
    #      --log_output "/results/compliance_${DATESTAMP}.out"           \
    #      "/results/${LOGBASE}_${_experiment_index}.log" \
	#  || true
done
