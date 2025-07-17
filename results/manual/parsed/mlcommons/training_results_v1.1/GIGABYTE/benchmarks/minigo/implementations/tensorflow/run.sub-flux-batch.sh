#!/bin/bash
#FLUX: --job-name=dlrm.hugectr
#FLUX: -t=1800
#FLUX: --urgency=16

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${NEXP:=100}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
: "${MOUNTS:='/raid/datasets:/raid/datasets,/gpfs/fs1:/gpfs/fs1'}"
: "${LOGDIR:=./results}"
if [ "${API_LOGGING:-}" -eq 1 ]; then
    MOUNTS="${MOUNTS},${API_LOG_DIR}:/logs"
fi
readonly _logfile_base="${LOGDIR}/${DATESTAMP}"
readonly _cont_name=dlrm
srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-image="${CONT}" --container-name="${_cont_name}" true
for _experiment_index in $(seq 1 "${NEXP}"); do
  (
    if [[ $CLEAR_CACHES == 1 ]]; then
      srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
      srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${_cont_name}" python3 -c "
from mlperf_logging.mllog import constants
from mlperf_logger.utils import log_event
log_event(key=constants.CACHE_CLEAR, value=True)"
    fi
    echo "Beginning trial ${_experiment_index} of ${NEXP}"
    srun --mpi=pmix --ntasks="${SLURM_JOB_NUM_NODES}" --ntasks-per-node=1 \
         --container-name="${_cont_name}" --container-mounts="${MOUNTS}" \
         ${LOGGER:-} ./run_and_time.sh
  ) |& tee "raw_results.log"
cat "raw_results.log" | grep ":::MLLOG" | sort -k5 -n -s | tee "${_logfile_base}_${_experiment_index}.log"
done
