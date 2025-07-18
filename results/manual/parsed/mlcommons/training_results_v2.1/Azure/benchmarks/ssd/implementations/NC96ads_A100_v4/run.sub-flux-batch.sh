#!/bin/bash
#FLUX: --job-name=single_stage_detector
#FLUX: --urgency=16

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${NEXP:=5}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${WORK_DIR:=/workspace/ssd}"
: "${CONT_NAME:=single_stage_detector}"
: "${DATADIR:=/raid/datasets/openimages/open-images-v6}"
: "${LOGDIR:=./results}"
: "${NVTX_FLAG:=0}"
: "${TIME_TAGS:=0}"
: "${NCCL_TEST:=0}"
: "${SYNTH_DATA:=0}"
: "${EPOCH_PROF:=0}"
: "${API_LOGGING:=0}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
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
readonly LOG_FILE_BASE="${LOGDIR}/${LOGBASE}"
CONT_MOUNTS="${DATADIR}:/datasets/open-images-v6,${LOGDIR}:/results,${TORCH_HOME}:/torch-home,/opt/microsoft/ncv4/topo.xml:/opt/microsoft/ncv4/topo.xml,/opt/microsoft/ncv4/graph.xml:/opt/microsoft/ncv4/graph.xml,/usr/lib/x86_64-linux-gnu/libnccl.so:/usr/lib/x86_64-linux-gnu/libnccl.so,/usr/include/nccl.h:/usr/include/nccl.h,${PWD}/azure.sh:/bm_utils/azure.sh,${PWD}/run_and_time.sh:/bm_utils/run_and_time.sh"
if [ "${API_LOGGING}" -eq 1 ]; then
    CONT_MOUNTS="${CONT_MOUNTS},${API_LOG_DIR}:/logs"
fi
mkdir -p "${LOGDIR}"
srun --ntasks="${SLURM_JOB_NUM_NODES}" mkdir -p "${LOGDIR}"
srun \
    --ntasks="${SLURM_JOB_NUM_NODES}" \
    --container-image="${CONT}" \
    --container-name="${CONT_NAME}" \
    true
echo "NCCL_TEST = ${NCCL_TEST}"
if [[ ${NCCL_TEST} -eq 1 ]]; then
    (srun --mpi=pmix --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
         --container-name="${CONT_NAME}" all_reduce_perf_mpi -b 33260119 -e 33260119 -d half -G 1    ) |& tee "${LOGDIR}/${SPREFIX}_nccl.log"
fi
for _experiment_index in $(seq -w 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
	echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST}"
        # Print system info
        srun -N1 -n1 --container-name="${CONT_NAME}" python -c "
import mlperf_log_utils
from mlperf_logging.mllog import constants
mlperf_log_utils.mlperf_submission_log(constants.SSD)"
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${CONT_NAME}" python -c "
from mlperf_logging import mllog
from mlperf_logging.mllog.constants import CACHE_CLEAR
mllogger = mllog.get_mllogger()
mllogger.event(key=CACHE_CLEAR, value=True)"
        fi
        # Run experiment
        srun \
            --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" \
            --ntasks-per-node="${DGXNGPU}" \
            --container-name="${CONT_NAME}" \
            --container-mounts="${CONT_MOUNTS}" \
            --container-workdir=${WORK_DIR} \
            /bm_utils/run_and_time.sh
    ) |& tee "${LOG_FILE_BASE}_${_experiment_index}.log"
done
