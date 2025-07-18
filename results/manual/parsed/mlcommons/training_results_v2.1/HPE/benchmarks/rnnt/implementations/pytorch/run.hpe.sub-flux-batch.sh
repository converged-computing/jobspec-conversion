#!/bin/bash
#FLUX: --job-name=MLPerf21-rnnt
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=mlperf
#FLUX: --urgency=16

export LOGDIR='${curDir}/logs/${SLURM_JOB_ID} #/lvol/logs/shm2'
export WORLD_SIZE='${SLURM_NPROCS}'
export RANK='$((${DGXNGPU}*${SLURM_NODEID}+${SLURM_LOCALID}))'
export MASTER_ADDR='${SLURMD_NODENAME}'
export MASTER_PORT='5678'

set -euxo pipefail
export LOGDIR=${curDir}/logs/${SLURM_JOB_ID} #/lvol/logs/shm2
case $FS in
        beeond | lvol | nfsond )
                mkdir -p /$FS/mlperf/
                pushd .
                cd /$FS/mlperf/
                tar xf /pfss/hddfs1/bruno/MLCOMMONS/training2.1/LibriSpeech.tar
                popd
		export DATADIR="/$FS/mlperf/LibriSpeech"
		export METADATA_DIR="/$FS/mlperf/LibriSpeech/tokenized"
		export SENTENCEPIECES_DIR="/$FS/mlperf/LibriSpeech/sentencepieces"
                ;;
        daos )
                srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "export LD_PRELOAD=/usr/lib64/libioil.so"
                mkdir -p /$FS/mlperf/
                pushd .
                cd /$FS/mlperf/
                tar xf /pfss/hddfs1/MLCOMMONS/training2.1/LibriSpeech.tar
                popd
		export DATADIR="/$FS/mlperf/LibriSpeech"
		export METADATA_DIR="/$FS/mlperf/LibriSpeech/tokenized"
		export SENTENCEPIECES_DIR="/$FS/mlperf/LibriSpeech/sentencepieces"
                ;;
        pfss)
                SBATCH_FS=''
		export DATADIR="/pfss/nvmefs1/bruno/MLCOMMONS/training2.1/LibriSpeech"
		export METADATA_DIR="/pfss/nvmefs1/bruno/MLCOMMONS/training2.1/LibriSpeech/tokenized"
		export SENTENCEPIECES_DIR="/pfss/nvmefs1/bruno/MLCOMMONS/training2.1/LibriSpeech/sentencepieces"
                ;;
esac
export WORLD_SIZE=${SLURM_NPROCS}
export RANK=$((${DGXNGPU}*${SLURM_NODEID}+${SLURM_LOCALID}))
export MASTER_ADDR=${SLURMD_NODENAME}
export MASTER_PORT=5678
echo "Running Pytorch distributed with MASTER_ADDR=$MASTER_ADDR , WORLD_SIZE=$WORLD_SIZE and RANK=$RANK"
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
_cont_mounts="/apps:/apps,/nfs:/nfs,${SCRIPTDIR}/pytorch:/workspace/rnnt,${DATADIR}:/datasets/,${LOGDIR}:/results,${METADATA_DIR}:/metadata,${SENTENCEPIECES_DIR}:/sentencepieces"
if [ "${API_LOGGING:-0}" -eq 1 ]; then
    _cont_mounts="${_cont_mounts},${API_LOG_DIR}:/logs"
fi
if [ "${REMOUNT_WORKDIR:-0}" -eq 1 ]; then
    _cont_mounts="${_cont_mounts},$(pwd):/workspace/rnnt"
fi
MLPERF_HOST_OS=$(srun -N1 -n1 bash <<EOF
    source /etc/os-release
EOF
)
export MLPERF_HOST_OS
mkdir -p "${LOGDIR}"
srun --ntasks="${SLURM_JOB_NUM_NODES}" mkdir -p "${LOGDIR}"
srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-image="${CONT}" --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" true
echo "NCCL_TEST = ${NCCL_TEST}"
if [[ ${NCCL_TEST} -eq 1 ]]; then
    (srun --mpi=pmix --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
         --container-name="${_cont_name}"  --container-mounts="${_cont_mounts}" all_reduce_perf_mpi -b 98.1M -e 98.1M -d half
    ) |& tee "${LOGDIR}/${SPREFIX}_nccl.log"
fi
for _experiment_index in $(seq -w 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index#0} of ${NEXP}"
	echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST}"
        # Print system info
        #srun --nodes=1 --ntasks=1 --container-name="${_cont_name}" python -c ""
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${_cont_name}"  --container-mounts="${_cont_mounts}" python /workspace/rnnt/drop.py
        fi
        # Run experiment
        SEED=$(($SEED + ${_experiment_index#0})) srun --mpi=pmix --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
            --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" \
            ./run_and_time.sh
    ) |& tee "${_logfile_base}_${_experiment_index#0}.log"
done
