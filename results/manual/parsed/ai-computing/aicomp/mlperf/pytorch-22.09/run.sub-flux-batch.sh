#!/bin/bash
#FLUX: --job-name=adorable-sundae-9235
#FLUX: --exclusive
#FLUX: --urgency=16

export MAX_STEPS='100'

set -eux
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
: "${CONT:?CONT not set}"
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${NEXP:?NEXP not set}"
: "${MLPERF_RULESET:=2.1.0}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
: "${API_LOGGING:=0}"
: "${CLEAR_CACHES:=1}"
: "${CONT_FILE:=/lustre/fsw/containers/${SLURM_JOBID}_$(basename ${CONT}).squashfs}"
: "${CONTAINER_PRELOAD_LUSTRE:=0}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${LOGDIR:=./results}"
: "${NSYSCMD:=""}"
: "${NVTX_FLAG:=0}"
: "${TIME_TAGS:=0}"
: "${NCCL_TEST:=0}"
: "${SYNTH_DATA:=0}"
: "${EPOCH_PROF:=0}"
: "${DISABLE_CG:=0}"
: "${WORK_DIR:=/workspace/bert}"
readonly _cont_name=language_model
LOG_BASE="${DATESTAMP}"
SPREFIX="language_model_pytorch_${DGXNNODES}x${DGXNGPU}x${BATCHSIZE}_${DATESTAMP}"
if [ ${TIME_TAGS} -gt 0 ]; then
    LOG_BASE="${SPREFIX}_mllog"
fi
if [ ${NVTX_FLAG} -gt 0 ]; then
    if [[ "$LOG_BASE" == *'_'* ]];then
        LOG_BASE="${LOG_BASE}_nsys"
    else
        LOG_BASE="${SPREFIX}_nsys"
    fi
    if [[ ! -d "${NVMLPERF_NSIGHT_LOCATION}" ]]; then
	echo "$NVMLPERF_NSIGHT_LOCATION doesn't exist on this system!" 1>&2
	exit 1
    fi
fi
if [ ${SYNTH_DATA} -gt 0 ]; then
    if [[ "$LOG_BASE" == *'_'* ]];then
        LOG_BASE="${LOG_BASE}_synth"
    else
        LOG_BASE="${SPREFIX}_synth"
    fi
fi
if [ ${EPOCH_PROF} -gt 0 ]; then
    if [[ "$LOG_BASE" == *'_'* ]];then
        LOG_BASE="${LOG_BASE}_epoch"
    else
        LOG_BASE="${SPREFIX}_epoch"
    fi
fi
if [ ${DISABLE_CG} -gt 0 ]; then
    EXTRA_PARAMS=$(echo $EXTRA_PARAMS | sed 's/--use_cuda_graph//')
    if [[ "$LOG_BASE" == *'_'* ]];then
        LOG_BASE="${LOG_BASE}_nocg"
    else
        LOG_BASE="${SPREFIX}_nocg"
    fi
fi
if [ ${NVTX_FLAG--1} -gt 0 ] ||  [ ${TIME_TAGS--1} -gt 0 ]; then
export MAX_STEPS=100
fi
readonly LOG_FILE_BASE="${LOGDIR}/${LOG_BASE}"
cleanup_preload_lustre() {
    if [[ "${CONTAINER_PRELOAD_LUSTRE:-0}" != "0" ]]; then
	srun --ntasks=1 rm "${CONT_FILE:?ERROR!CONT_FILE!UNDEFINED}"
    fi
}
trap cleanup_preload_lustre EXIT
if [[ $CONTAINER_PRELOAD_LUSTRE -gt 0 ]]; then
    CONT_FILE="/lustre/fsw/containers/${SLURM_JOBID}_$(basename ${CONT}).squashfs"
    # Prepull container to LUSTRE
    srun --ntasks=1 enroot import --output ${CONT_FILE} docker://${CONT}
else
    CONT_FILE=${CONT}
fi
echo "CI directory structure\n"
echo $(ls)
CONT_MOUNTS=$(func_get_container_mounts $(func_update_file_path_for_ci mounts.txt ${PWD}/language_model/pytorch))
CONT_MOUNTS="${CONT_MOUNTS},${LOGDIR}:/results"
if [[ "${NVTX_FLAG}" -gt 0 ]]; then
    CONT_MOUNTS="${CONT_MOUNTS},${NVMLPERF_NSIGHT_LOCATION}:/nsight"
fi
if [ "${API_LOGGING}" -eq 1 ]; then
    CONT_MOUNTS="${CONT_MOUNTS},${API_LOG_DIR}:/logs"
fi
( umask 0002; mkdir -p "${LOGDIR}" )
echo MELLANOX_VISIBLE_DEVICES="${MELLANOX_VISIBLE_DEVICES:-}"
srun --ntasks="$((SLURM_JOB_NUM_NODES))" --container-image="${CONT_FILE}" --container-name="${_cont_name}" true
srun -N1 -n1 --container-name="${_cont_name}" ibv_devinfo --list
srun -N1 -n1 --container-name="${_cont_name}" nvidia-smi topo -m
echo "NCCL_TEST = ${NCCL_TEST}"
if [[ ${NCCL_TEST} -eq 1 ]]; then
    (srun --mpi=pmix --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
         --container-name="${_cont_name}" all_reduce_perf_mpi -b 21M -e 672M -d half -G 1 -f 2 ) |& tee "${LOGDIR}/${SPREFIX}_nccl.log"
fi
for _experiment_index in $(seq -w 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
	echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST}"
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${_cont_name}" python -c "
from mlperf_logger import mllogger
mllogger.event(key=mllogger.constants.CACHE_CLEAR, value=True)"
        fi
        # Run experiment
      srun -l --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" --container-name="${_cont_name}" --container-mounts="${CONT_MOUNTS}" --container-workdir=${WORK_DIR} "run_and_time.sh"
    ) |& tee "${LOG_FILE_BASE}_${_experiment_index}.log"
    # compliance checker
    srun --ntasks=1 --nodes=1 --container-name="${_cont_name}" \
         --container-mounts="$(realpath ${LOGDIR}):/results"   \
         --container-workdir="/results"                        \
         python3 -m mlperf_logging.compliance_checker --usage training \
         --ruleset "${MLPERF_RULESET}"                                 \
         --log_output "/results/compliance_${DATESTAMP}.out"           \
         "/results/${LOG_BASE}_${_experiment_index}.log" \
	|| true
done
