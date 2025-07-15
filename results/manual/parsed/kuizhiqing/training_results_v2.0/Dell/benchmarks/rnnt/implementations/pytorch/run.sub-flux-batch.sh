#!/bin/bash
#FLUX: --job-name=mlperf-training:rnnt
#FLUX: --priority=16

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${NEXP:=10}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${DATADIR:=/lustre/fsr/datasets/speech/jasper/LibriSpeech/}"
: "${LOGDIR:=./results}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
: "${SEED:=$RANDOM}"
: "${WALLTIME_DRYRUN:=$WALLTIME}"
: "${METADATA_DIR:=''}"
LOGBASE="${DATESTAMP}"
SPREFIX="rnn_speech_recognition_pytorch_${DGXNNODES}x${DGXNGPU}x${BATCHSIZE}_${DATESTAMP}"
TIME_TAGS=${TIME_TAGS:-0}
NVTX_FLAG=${NVTX_FLAG:-0}
NCCL_TEST=${NCCL_TEST:-0}
SYNTH_DATA=${SYNTH_DATA:-0}
EPOCH_PROF=${EPOCH_PROF:-0}
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
readonly _logfile_base="${LOGDIR}/${LOGBASE}"
readonly _cont_name=rnn_speech_recognition
_cont_mounts="${DATADIR}:/datasets/,${LOGDIR}:/results"
_cont_mounts+=",${METADATA_DIR}:/metadata"
_cont_mounts+=",${SENTENCEPIECES_DIR}:/sentencepieces"
if [ "${API_LOGGING:-0}" -eq 1 ]; then
    _cont_mounts="${_cont_mounts},${API_LOG_DIR}:/logs"
fi
if [ "${REMOUNT_WORKDIR:-0}" -eq 1 ]; then
    _cont_mounts="${_cont_mounts},$(pwd):/workspace/rnnt"
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
echo "NCCL_TEST = ${NCCL_TEST}"
if [[ ${NCCL_TEST} -eq 1 ]]; then
    (srun --mpi=pmix --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
         --container-name="${_cont_name}" all_reduce_perf_mpi -b 98.1M -e 98.1M -d half
    ) |& tee "${LOGDIR}/${SPREFIX}_nccl.log"
fi
for _experiment_index in $(seq -w 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
	echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST}"
        # Print system info
        srun --nodes=1 --ntasks=1 --container-name="${_cont_name}" python -c ""
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${_cont_name}" python -c "
from mlperf import logging
logging.log_event(key=logging.constants.CACHE_CLEAR, value=True)"
        fi
        # Run experiment
        srun --mpi=none --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
            --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" \
            ./run_and_time.sh
    ) |& tee "${_logfile_base}_${_experiment_index}.log"
done
