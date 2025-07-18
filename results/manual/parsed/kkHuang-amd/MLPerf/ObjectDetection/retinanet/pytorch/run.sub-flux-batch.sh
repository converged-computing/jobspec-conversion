#!/bin/bash
#FLUX: --job-name=retinanet
#FLUX: --urgency=16

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${MLPERF_RULESET:=2.1.0}"
: "${NEXP:=5}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S')}"
: "${CLEAR_CACHES:=1}"
: "${WORK_DIR:=/workspace/retinanet}"
: "${CONT_NAME:=retinanet-rocm}"
: "${LOGDIR:=./results}"
: "${NVTX_FLAG:=0}"
: "${TIME_TAGS:=0}"
: "${NCCL_TEST:=0}"
: "${SYNTH_DATA:=0}"
: "${EPOCH_PROF:=0}"
: "${DISABLE_CG:=1}"
: "${API_LOGGING:=0}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
LOGBASE="${DATESTAMP}"
SPREFIX="retinanet_pytorch_${DGXNNODES}x${DGXNGPU}x${BATCHSIZE}_${DATESTAMP}"
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
if [[ "${LOCALDISK_FROM_SQUASHFS:-}" ]]; then
    # LOCALDISK_FROM_SQUASHFS should be the path/name of a squashfs file on /lustre
    echo "fetching ${LOCALDISK_FROM_SQUASHFS}"
    dd bs=4M if="${LOCALDISK_FROM_SQUASHFS}" of=/raid/scratch/tmp.sqsh oflag=direct
    echo "unsquashing /raid/scratch/tmp.sqsh"
    time unsquashfs -no-progress -dest /raid/scratch/local-root /raid/scratch/tmp.sqsh
fi
readonly LOG_FILE_BASE="${LOGDIR}/${LOGBASE}"
CONT_MOUNTS="${DATADIR}:/datasets/open-images-v6,${LOGDIR}:/results,${BACKBONE_DIR}:/root/.cache/torch"
if [[ "${NVTX_FLAG}" -gt 0 ]]; then
    CONT_MOUNTS="${CONT_MOUNTS},${NVMLPERF_NSIGHT_LOCATION}:/nsight"
fi
if [ "${API_LOGGING}" -gt 0 ]; then
    CONT_MOUNTS="${CONT_MOUNTS},${API_LOG_DIR}:/logs"
fi
( mkdir -p "${LOGDIR}" )
srun --ntasks="${SLURM_JOB_NUM_NODES}" mkdir -p "${LOGDIR}"
echo MELLANOX_VISIBLE_DEVICES="${MELLANOX_VISIBLE_DEVICES:-}"
srun \
    --ntasks="${SLURM_JOB_NUM_NODES}" \
    --container-image="${CONT}" \
    --container-name="${CONT_NAME}" \
    true
srun -N1 -n1 --container-name="${CONT_NAME}" ibv_devinfo --list
srun -N1 -n1 --container-name="${CONT_NAME}" nvidia-smi topo -m
echo "NCCL_TEST = ${NCCL_TEST}"
if [[ ${NCCL_TEST} -gt 0 ]]; then
    (srun --mpi=pmix --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
         --container-name="${CONT_NAME}" all_reduce_perf_mpi -b 33260119 -e 33260119 -d half -G 1    ) |& tee "${LOGDIR}/${SPREFIX}_nccl.log"
fi
for _experiment_index in $(seq -w 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
        echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST}"
        # Print system info
        srun -N1 -n1 --container-name="${CONT_NAME}" python -c ""
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${CONT_NAME}" python -c "
from mlperf_logger import mllogger
mllogger.event(key=mllogger.constants.CACHE_CLEAR, value=True)"
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
    # compliance checker
    srun --ntasks=1 --nodes=1 --container-name="${CONT_NAME}" \
         --container-mounts="$(realpath ${LOGDIR}):/results"   \
         --container-workdir="/results"                        \
         python3 -m mlperf_logging.compliance_checker --usage training \
         --ruleset "${MLPERF_RULESET}"                                 \
         --log_output "/results/compliance_${DATESTAMP}.out"           \
         "/results/${LOGBASE}_${_experiment_index}.log" \
	 || true
done
