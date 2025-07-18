#!/bin/bash
#FLUX: --job-name=MLPerf21-resnet50
#FLUX: -c=8
#FLUX: --exclusive
#FLUX: --queue=mlperf
#FLUX: --urgency=16

export LOGDIR='${curDir}/logs/${SLURM_JOB_ID} #/lvol/logs/shm2'

set -euxo pipefail
export LOGDIR=${curDir}/logs/${SLURM_JOB_ID} #/lvol/logs/shm2
case $FS in
        beeond | lvol | nfsond )
		mkdir -p /$FS/bruno/mlperf/
		pushd .
		cd /$FS/bruno/mlperf/
		tar xf /pfss/hddfs1/bruno/MLCOMMONS/training2.1/resnet.bz2
		popd
		export DATADIR="/${FS}/bruno/mlperf/resnet/preprocess"
                ;;
        daos )
		srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "export LD_PRELOAD=/usr/lib64/libioil.so"
		mkdir -p /$FS/bruno/mlperf/
		pushd .
		cd /$FS/bruno/mlperf/
		tar xf /pfss/hddfs1/bruno/MLCOMMONS/training2.1/resnet.bz2
		popd
		export DATADIR="/${FS}/bruno/mlperf/resnet/preprocess"
                ;;
        pfss)
                SBATCH_FS=''
		export DATADIR="${TGT_DIR}/resnet/preprocess"
                ;;
esac
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${NEXP:=5}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${DATADIR:=/raid/datasets/train-val-recordio-passthrough}"
: "${LOGDIR:=./results}"
: "${COPY_DATASET:=}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
TIME_TAGS=${TIME_TAGS:-0}
NVTX_FLAG=${NVTX_FLAG:-0}
NCCL_TEST=${NCCL_TEST:-0}
SYNTH_DATA=${SYNTH_DATA:-0}
EPOCH_PROF=${EPOCH_PROF:-0}
echo $COPY_DATASET
if [ ! -z $COPY_DATASET ]; then
  readonly copy_datadir=$COPY_DATASET
  srun --ntasks-per-node=1 mkdir -p "${DATADIR}"
  srun --ntasks-per-node=1 ${CODEDIR}/copy-data.sh "${copy_datadir}" "${DATADIR}"
  srun --ntasks-per-node=1 bash -c "ls ${DATADIR}"
fi
LOGBASE="${DATESTAMP}"
SPREFIX="image_classification_mxnet_${DGXNNODES}x${DGXNGPU}x${BATCHSIZE}_${DATESTAMP}"
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
readonly _seed_override=${SEED:-}
readonly _logfile_base="${LOGDIR}/${LOGBASE}"
readonly _cont_name=image_classification
_cont_mounts="/nfs:/nfs,/apps:/apps,${SCRIPTDIR}/mxnet:/workspace/image_classification,${DATADIR}:/data,${LOGDIR}:/results"
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
srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-image="${CONT}" --container-mounts="${_cont_mounts}" --container-name="${_cont_name}" true
echo "NCCL_TEST = ${NCCL_TEST}"
if [[ ${NCCL_TEST} -eq 1 ]]; then
    (srun --mpi=pmix --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))"  --container-mounts="${_cont_mounts}" --ntasks-per-node="${DGXNGPU}" \
         --container-name="${_cont_name}" all_reduce_perf_mpi -b 51.2M -e 51.2M -d half -G 1    ) |& tee "${LOGDIR}/${SPREFIX}_nccl.log"
fi
for _experiment_index in $(seq -w 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
	echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST}"
        # Print system info
        srun -N1 -n1 --container-name="${_cont_name}"  --container-mounts="${_cont_mounts}" python /workspace/image_classification/show_resnet.py 
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${_cont_name}"  --container-mounts="${_cont_mounts}" python /workspace/image_classification/drop.py
        fi
        # Run experiment
        export SEED=${_seed_override:-$RANDOM}
        srun --kill-on-bad-exit=0 --mpi=pmix --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
            --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" \
            ./run_and_time.sh
    ) |& tee "${_logfile_base}_${_experiment_index}.log"
done
