#!/bin/bash
#FLUX: --job-name=rnn_speech_recognition
#FLUX: --urgency=16

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${NEXP:=1}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${DATADIR:=/lustre/fsr/datasets/speech/jasper/LibriSpeech/}"
: "${LOGDIR:=./results}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
: "${SEED:=$RANDOM}"
: "${WALLTIME_DRYRUN:=$WALLTIME}"
: "${METADATA_DIR:=''}"
readonly _logfile_base="${LOGDIR}/${DATESTAMP}"
readonly _cont_name=dlc-pt
_cont_mounts="${DATADIR}:/datasets/,${LOGDIR}:/results"
_cont_mounts+=",${METADATA_DIR}:/metadata"
_cont_mounts+=",${SENTENCEPIECES_DIR}:/sentencepieces"
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
if [[ $DGXSYSTEM == "DGXA100"* ]]; then
  export NCCL_TOPO_FILE="/workspace/rnnt/dgxa100_nic_affinity.xml"
  echo "using NCCL_TOPO_FILE ${NCCL_TOPO_FILE}"
fi
for _experiment_index in $(seq 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
        # Print system info
        srun --nodes=1 --ntasks=1 --container-name="${_cont_name}" python -c ""
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${_cont_name}" bash -c "ls workspace/rnnt && cd /workspace/rnnt && python -c \"
from mlperf import logging
logging.log_event(key=logging.constants.CACHE_CLEAR, value=True)\""
        fi
        # Run experiment
        SEED=$(($SEED + $_experiment_index)) srun --mpi=none --ntasks="${SLURM_JOB_NUM_NODES}" --ntasks-per-node="${DGXNGPU}" \
            --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" \
            bash -c 'cd workspace/rnnt && ./run_and_time.sh'
    ) |& tee "${_logfile_base}_${_experiment_index}.log"
done
