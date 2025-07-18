#!/bin/bash
#FLUX: --job-name=object_detection
#FLUX: --urgency=16

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${NEXP:=5}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${DATADIR:=/raid/datasets/coco/coco-2017}"
: "${LOGDIR:=./results}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
LOGBASE="mskcrnn_${DGXNNODES}x${DGXNGPU}x${BATCHSIZE}_${DATESTAMP}"
TIME_TAGS=${TIME_TAGS:-0}
NVTX_FLAG=${NVTX_FLAG:-0}
if [ ${TIME_TAGS} -gt 0 ]; then
    LOGBASE="${LOGBASE}_mllog"
fi
if [ ${NVTX_FLAG} -gt 0 ]; then
    LOGBASE="${LOGBASE}_nsys"
fi
readonly _logfile_base="${LOGDIR}/${LOGBASE}"
readonly _cont_name=object_detection
_cont_mounts="${DATADIR}:/data,${LOGDIR}:/results"
_cont_mounts+=",${PWD}/bind.sh:/bm_utils/bind.sh"
_cont_mounts+=",${PWD}/azure.sh:/bm_utils/azure.sh"
_cont_mounts+=",${PWD}/run_and_time.sh:/bm_utils/run_and_time.sh"
_cont_mounts+=",/opt/microsoft:/opt/microsoft"
if [ "${API_LOGGING:-}" -eq 1 ]; then
    _cont_mounts="${_cont_mounts},${API_LOG_DIR}:/logs"
fi
MLPERF_HOST_OS=$(srun -N1 -n1 bash <<EOF
    source /etc/os-release
    source /etc/dgx-release || true
    echo "\${PRETTY_NAME} / \${DGX_PRETTY_NAME:-???} \${DGX_OTA_VERSION:-\${DGX_SWBUILD_VERSION:-???}}"
EOF
)
export MLPERF_HOST_OS
mkdir -p "${LOGDIR}"
srun --ntasks="${SLURM_JOB_NUM_NODES}" mkdir -p "${LOGDIR}"
srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-image="${CONT}" --container-name="${_cont_name}" true
for _experiment_index in $(seq 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
        # Print system info
        srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${_cont_name}" python -c "
from mlperf_logging.mllog import constants
from maskrcnn_benchmark.utils.mlperf_logger import mlperf_submission_log
mlperf_submission_log(constants.MASKRCNN)"
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${_cont_name}" python -c "
from mlperf_logging.mllog import constants
from maskrcnn_benchmark.utils.mlperf_logger import log_event
log_event(key=constants.CACHE_CLEAR, value=True, stack_offset=1)"
        fi
        # Run experiment
        srun --mpi=none --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
            --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" \
            /bm_utils/run_and_time.sh
    ) |& tee "${_logfile_base}_${_experiment_index}.log"
done
