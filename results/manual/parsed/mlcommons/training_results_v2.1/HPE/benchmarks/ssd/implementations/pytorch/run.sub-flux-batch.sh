#!/bin/bash
#FLUX: --job-name=ssd_mlpv21
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=mlperf
#FLUX: -t=7200
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
: "${WORK_DIR:=/workspace/ssd}"
: "${CONT_NAME:=single_stage_detector}"
: "${LOGDIR:=./results}"
: "${NVTX_FLAG:=0}"
: "${TIME_TAGS:=0}"
: "${NCCL_TEST:=0}"
: "${SYNTH_DATA:=0}"
: "${EPOCH_PROF:=0}"
: "${DISABLE_CG:=0}"
: "${API_LOGGING:=0}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
export WORLD_SIZE=${SLURM_NPROCS}
export RANK=$((${DGXNGPU}*${SLURM_NODEID}+${SLURM_LOCALID}))
export MASTER_ADDR=${SLURMD_NODENAME}
export MASTER_PORT=5678
echo "[HPE] setting distributed info WORLD_SIZE=$WORLD_SIZE, MASTER_ADDR=$MASTER_ADDR MASTER_PORT=$MASTER_PORT"
LOGBASE="${DATESTAMP}"
SPREFIX="single_stage_detector_pytorch_${DGXNNODES}x${DGXNGPU}x${BATCHSIZE}_${DATESTAMP}"
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
    EXTRA_PARAMS=$(echo $EXTRA_PARAMS | sed 's/--cuda-graphs//')
    if [[ "$LOGBASE" == *'_'* ]];then
        LOGBASE="${LOGBASE}_nocg"
    else
        LOGBASE="${SPREFIX}_nocg"
    fi
fi
export LOGDIR="${LOGDIR}/${SLURM_JOB_ID}"
if [[ "${LOCALDISK_FROM_SQUASHFS:-}" ]]; then
    # LOCALDISK_FROM_SQUASHFS should be the path/name of a squashfs file on /lustre
    echo "fetching ${LOCALDISK_FROM_SQUASHFS}"
    dd bs=4M if="${LOCALDISK_FROM_SQUASHFS}" of=/raid/scratch/tmp.sqsh oflag=direct
    echo "unsquashing /raid/scratch/tmp.sqsh"
    time unsquashfs -no-progress -dest /raid/scratch/local-root /raid/scratch/tmp.sqsh
fi
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
CONT_MOUNTS=$(func_get_container_mounts $(func_update_file_path_for_ci mounts.txt ${PWD}))
readonly LOG_FILE_BASE="${LOGDIR}/${LOGBASE}"
CONT_MOUNTS+=",${DATADIR}:/datasets/open-images-v6,${LOGDIR}:/results"
CONT_MOUNTS+=",${BACKBONE_DIR}:/root/.cache/torch"
CONT_MOUNTS+=",${BACKBONE_DIR}:/workspace/ssd/root/.cache/torch"
CONT_MOUNTS+=",${PWD}:${WORK_DIR}"
if [[ "${NVTX_FLAG}" -gt 0 ]]; then
    CONT_MOUNTS="${CONT_MOUNTS},${NVMLPERF_NSIGHT_LOCATION}:/nsight"
fi
if [ "${API_LOGGING}" -eq 1 ]; then
    CONT_MOUNTS="${CONT_MOUNTS},${API_LOG_DIR}:/logs"
fi
echo MELLANOX_VISIBLE_DEVICES="${MELLANOX_VISIBLE_DEVICES:-}"
srun \
    --ntasks="${SLURM_JOB_NUM_NODES}" \
    --container-image="${CONT}" \
    --container-name="${CONT_NAME}" \
    --container-mounts="${CONT_MOUNTS}" true
for _experiment_index in $(seq -w 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
	echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST}"
        # Print system info
        # srun -N1 -n1 --container-name="${CONT_NAME}" python -c ""
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-mounts="${CONT_MOUNTS}" --container-name="${CONT_NAME}" python ${WORK_DIR}/drop.py 
        fi
        # Run experiment
        srun \
            --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" \
            --ntasks-per-node="${DGXNGPU}" \
            --container-name="${CONT_NAME}" \
            --container-mounts="${CONT_MOUNTS}" \
            --container-workdir=${WORK_DIR} \
            ./run_and_time.sh
    ) |& tee "${LOG_FILE_BASE}_${_experiment_index}.log"
    # # compliance checker
    # srun --ntasks=1 --nodes=1 --container-name="${CONT_NAME}" \
    #      --container-mounts="$(realpath ${LOGDIR}):/results"   \
    #      --container-workdir="/results"                        \
    #      python3 -m mlperf_logging.compliance_checker --usage training \
    #      --ruleset "${MLPERF_RULESET}"                                 \
    #      --log_output "/results/compliance_${DATESTAMP}.out"           \
    #      "/results/${LOGBASE}_${_experiment_index}.log" \
	#  || true
done
