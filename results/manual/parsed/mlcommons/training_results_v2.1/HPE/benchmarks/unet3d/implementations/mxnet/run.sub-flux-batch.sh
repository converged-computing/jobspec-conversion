#!/bin/bash
#FLUX: --job-name=unet3d_mlpv21
#FLUX: -c=8
#FLUX: --queue=mlperf
#FLUX: -t=14400
#FLUX: --priority=16

export LOGDIR='${LOGDIR}/${SLURM_JOB_ID}'
export MLPERF_HOST_OS='Apollo6500_Gen10plus'

set -eux
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${NEXP:=40}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${DATADIR:=/raid/datasets/mlperft-unet3d/kits19/}"
: "${LOGDIR:=./results}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
TIME_TAGS=${TIME_TAGS:-0}
NVTX_FLAG=${NVTX_FLAG:-0}
NCCL_TEST=${NCCL_TEST:-0}
SYNTH_DATA=${SYNTH_DATA:-0}
EPOCH_PROF=${EPOCH_PROF:-0}
LOGBASE="${DATESTAMP}"
SPREFIX="image_segmentation_mxnet_${DGXNNODES}x${DGXNGPU}x${BATCH_SIZE}_${DATESTAMP}"
if [ ${TIME_TAGS} -gt 0 ]; then
    LOGBASE="${SPREFIX}_mllog"
fi
if [ ${NVTX_FLAG} -gt 0 ]; then
    if [[ "$LOGBASE" == *'_'* ]];then
        LOGBASE="${LOGBASE}_nsys"
    else
        LOGBASE="${SPREFIX}_nsys"
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
export LOGDIR="${LOGDIR}/${SLURM_JOB_ID}"
readonly _logfile_base="${LOGDIR}/${LOGBASE}"
readonly _cont_name=image_segmentation
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
_cont_mounts+=",${DATADIR}:/data,${LOGDIR}:/results"
_cont_mounts+=",${PWD}:/workspace/image_segmentation"
if [ "${API_LOGGING:-}" -eq 1 ]; then
    _cont_mounts="${_cont_mounts},${API_LOG_DIR}:/logs"
fi
export MLPERF_HOST_OS="Apollo6500_Gen10plus"
mkdir -p "${LOGDIR}"
srun \
    --ntasks="${SLURM_JOB_NUM_NODES}" \
    --container-image="${CONT}" \
    --container-name="${_cont_name}" \
    --container-mounts="${_cont_mounts}" true
    true
echo "NCCL_TEST = ${NCCL_TEST}"
if [[ ${NCCL_TEST} -eq 1 ]]; then
    (srun \
        --mpi=pmix \
        --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" \
        --ntasks-per-node="${DGXNGPU}" \
        --container-name="${_cont_name}" \
        --container-mounts="${_cont_mounts}" \
        all_reduce_perf_mpi -b 62M -e 62M -d half
) |& tee "${LOGDIR}/${SPREFIX}_nccl.log"
fi
for _experiment_index in $(seq -w 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
	    echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST}"
        # Print system info
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun \
                --ntasks="${SLURM_JOB_NUM_NODES}" \
                bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
        fi
        # Run experiment
        srun --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" \
            --ntasks-per-node="${DGXNGPU}" \
            --container-name="${_cont_name}" \
            --container-mounts="${_cont_mounts}" \
            /workspace/image_segmentation/run_and_time.sh
    ) |& tee "${_logfile_base}_${_experiment_index}.log"
done
