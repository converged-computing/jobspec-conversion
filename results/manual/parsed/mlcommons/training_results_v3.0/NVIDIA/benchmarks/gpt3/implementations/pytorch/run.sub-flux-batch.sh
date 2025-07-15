#!/bin/bash
#FLUX: --job-name=expressive-carrot-3414
#FLUX: --exclusive
#FLUX: --priority=16

export SHARE_RERUNS='${SHARE_RERUNS:=0}'
export MLPERF_SLURM_FIRSTNODE='$(scontrol show hostnames "${SLURM_JOB_NODELIST-}" | head -n1)'
export MODEL_NAME='large_language_model'
export MODEL_FRAMEWORK='pytorch'

set -eux
: "${CONT:?CONT not set}"
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${NEXP:?NEXP not set}"
: "${WALLTIME:=?WALLTIME not set}"
: "${MLPERF_RULESET:=3.0.0}"
: "${CHECK_COMPLIANCE:=1}"
: "${SEED_BASE:=${SEED-$RANDOM}}"
export SHARE_RERUNS=${SHARE_RERUNS:=0}
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
: "${API_LOGGING:=0}"
: "${CLEAR_CACHES:=1}"
: "${CONT_FILE:=/lustre/fsw/containers/${SLURM_JOBID}_$(basename ${CONT}).squashfs}"
: "${CONT_NAME:=llm}"
: "${CONTAINER_PRELOAD_LUSTRE:=0}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${LOGDIR:=./results}"
: "${ABSLOGDIR:=${PWD}/results}"
: "${POWERCMDDIR:=' '}"
: "${NSYSCMD:=""}"
: "${NVTX_FLAG:=0}"
: "${TIME_TAGS:=0}"
: "${NCCL_TEST:=1}"
: "${SYNTH_DATA:=0}"
: "${EPOCH_PROF:=0}"
: "${WORK_DIR:=/workspace/llm}"
: "${DGXNGPU:=8}"
: "${STORE_CKPTS_IN_LOGDIR:=1}"
: "${CHECKPOINTS_DIR:=}"
: "${GLOBAL_TMP_NPY_INDEX_DIR:=$LOGDIR}"
: "${GLOBAL_TMP_CHECKPOINTS_DIR:=}"
: "${SRUN_KILL_ON_BAD_EXIT:=0}"
: "${DROPCACHE_CMD:="sudo /sbin/sysctl vm.drop_caches=3"}"
: "${NPY_INDEX_DIR:=${GLOBAL_TMP_NPY_INDEX_DIR}/${DATESTAMP}_npy_index}"
: "${CLEANUP_NPY_INDEX_DIR:=1}"
if [[ "${SLURM_JOB_ID}" ]]; then
    export RUNSUB_DIR=$(dirname $(scontrol show job "${SLURM_JOB_ID}" | awk -F= '/Command=/{print $2}'))
else
    export RUNSUB_DIR=$(dirname "${BASH_SOURCE[0]}")
fi
export MLPERF_SLURM_FIRSTNODE="$(scontrol show hostnames "${SLURM_JOB_NODELIST-}" | head -n1)"
cleanup_pyxis() {
    srun --ntasks="${SLURM_JOB_NUM_NODES}" /bin/bash -c 'if [[ "$(enroot list)" ]]; then enroot remove -f $(enroot list); fi'
}
cleanup_pyxis
readonly CONT_NAME="llm_${SLURM_JOB_ID}"
export MODEL_NAME="large_language_model"
export MODEL_FRAMEWORK="pytorch"
LOG_BASE="${DATESTAMP}"
SPREFIX="${MODEL_NAME}_${MODEL_FRAMEWORK}_${DGXNNODES}x${DGXNGPU}_${DATESTAMP}"
if [ ${SHARE_RERUNS:-0} -eq 1 ]; then
  export NEMO_RESULTS_SUBDIR='shared_logs'
else
  export NEMO_RESULTS_SUBDIR=$LOG_BASE
fi
if [ -z "${CHECKPOINTS_DIR}" ] && [ ${STORE_CKPTS_IN_LOGDIR:-1} -eq 0 ]; then
  if [ -z "${GLOBAL_TMP_CHECKPOINTS_DIR}" ]; then
    echo "Error: if STORE_CKPTS_IN_LOGDIR=0, either CHECKPOINTS_DIR or GLOBAL_TMP_CHECKPOINTS_DIR must be set."
    exit 1
  fi
  LOGDIR_SUFFIX=${LOGDIR#$(dirname $(dirname $(dirname $LOGDIR)))}
  CHECKPOINTS_DIR=${GLOBAL_TMP_CHECKPOINTS_DIR}/$LOGDIR_SUFFIX/checkpoints  # take 3 immediate parents of LOGDIR
  echo "Storing checkpoints in CHECKPOINTS_DIR=${CHECKPOINTS_DIR}."
  ( umask 0002; mkdir -p "${CHECKPOINTS_DIR}" )
fi
( umask 0002; mkdir -p "${LOGDIR}"; mkdir -p "${LOGDIR}/${NEMO_RESULTS_SUBDIR}"; mkdir -p $NPY_INDEX_DIR )
if [ ${TIME_TAGS} -gt 0 ]; then
    LOG_BASE="${SPREFIX}_mllog"
fi
if [ ${NVTX_FLAG} -gt 0 ]; then
    if [[ "$LOG_BASE" == *'-'* ]];then
        LOG_BASE="${LOG_BASE}_nsys"
    else
        LOG_BASE="${SPREFIX}_nsys"
    fi
fi
if [ ${SYNTH_DATA} -gt 0 ]; then
    if [[ "$LOG_BASE" == *'-'* ]];then
        LOG_BASE="${LOG_BASE}_synth"
    else
        LOG_BASE="${SPREFIX}_synth"
    fi
fi
if [ ${EPOCH_PROF} -gt 0 ]; then
    if [[ "$LOG_BASE" == *'-'* ]];then
        LOG_BASE="${LOG_BASE}_epoch"
    else
        LOG_BASE="${SPREFIX}_epoch"
    fi
fi
readonly LOG_FILE_BASE="${LOGDIR}/${LOG_BASE}"
cleanup_preload_lustre() {
    if [[ "${CONTAINER_PRELOAD_LUSTRE:-0}" != "0" ]]; then
	# since this command only needs to run once, and impacts the global
	# file system, not something local to nodes, we don't need to run it
	# under srun.  It's preferable to run this directly, rarther than under
	# srun, because if we're running cleanup because we exceeded our time
	# limit, slurm won't launch a new srun for us, while just running a
	# command directly should work
	rm "${CONT_FILE:?ERROR!CONT_FILE!UNDEFINED}"
    fi
}
if [[ $CONTAINER_PRELOAD_LUSTRE -gt 0 ]]; then
    CONT_FILE="/lustre/fsw/containers/${SLURM_JOBID}_$(basename ${CONT}).squashfs"
    # Prepull container to LUSTRE
    srun --ntasks=1 enroot import --output ${CONT_FILE} docker://${CONT}
else
    CONT_FILE=${CONT}
fi
echo "CI directory structure\n"
echo $(ls)
MOUNTS="${LOGDIR}:/results,${NPY_INDEX_DIR}:/npy_index,${MOUNTS}"
echo MOUNTS="${MOUNTS}"
if [ "${API_LOGGING}" -eq 1 ]; then
    API_LOG_DIR=${API_LOG_DIR}/${MODEL_FRAMEWORK}/${MODEL_NAME}/${DGXSYSTEM}
    mkdir -p ${API_LOG_DIR}
    MOUNTS="${MOUNTS},${API_LOG_DIR}:/logs"
fi
if [ -n "${CHECKPOINTS_DIR}" ]; then
    MOUNTS="${MOUNTS},${CHECKPOINTS_DIR}:/results/${NEMO_RESULTS_SUBDIR}/checkpoints"
fi
if [ "${REMOUNT_WORKDIR:-0}" -eq 1 ]; then
    echo 'Remounting workdir'
    MOUNTS="$(pwd):/workspace/llm,${MOUNTS}"
fi
if [ -n "${REMOUNT_NEMO_PATH:-}" ]; then
    echo "Remounting Nemo from ${REMOUNT_NEMO_PATH}"
    MOUNTS="${REMOUNT_NEMO_PATH}:/opt/bignlp/NeMo,${MOUNTS},${REMOUNT_NEMO_PATH}:/workspace/NeMo,${MOUNTS}"
fi
SRUN_EXTRA_ARGS=""
if [ "${SRUN_KILL_ON_BAD_EXIT}" -eq 1 ]; then
    SRUN_EXTRA_ARGS+=" --kill-on-bad-exit=1"
fi
cleanup_npy_index_dir() {
    if [[ $CLEANUP_NPY_INDEX_DIR -gt 0 ]]; then
	# since this command only needs to run once, and impacts the global
	# file system, not something local to nodes, we don't need to run it
	# under srun.  It's preferable to run this directly, rarther than under
	# srun, because if we're running cleanup because we exceeded our time
	# limit, slurm won't launch a new srun for us, while just running a
	# command directly should work
	rm -rf "${NPY_INDEX_DIR}"
    fi
}
cleanup_containers() {
    cleanup_npy_index_dir
    cleanup_preload_lustre
    cleanup_pyxis
}
trap cleanup_containers TERM EXIT
if [[ "${TARFILE_FOR_PREPROC_DATA:-}" ]]; then
    # make sure we didn't accidentally specify the remote disk as the tmpdir
    if [[ "${PREPROC_DATA}" == *mnt* ]]; then
	echo "ERROR: ${PREPROC_DATA} looks like a lustre mount rather than a tmp dir, yet TARFILE_FOR_PREPROC_DATA is set to ${TARFILE_FOR_PREPROC_DATA}!!!"
	exit 1
    fi
    # manage data in tmpdir on every node
    srun --ntasks="${SLURM_JOB_NUM_NODES}" \
	 "${RUNSUB_DIR}/manage-tmp-data" \
	 "${TARFILE_FOR_PREPROC_DATA}" "${PREPROC_DATA}"   \
	 "${MD5SUM_FOR_PREPROC_DATA}"
fi
echo MELLANOX_VISIBLE_DEVICES="${MELLANOX_VISIBLE_DEVICES:-}"
srun --ntasks="$((SLURM_JOB_NUM_NODES))" --container-image="${CONT_FILE}" --container-name="${CONT_NAME}" true
srun -N1 -n1 --container-name="${CONT_NAME}" ibv_devinfo --list
srun -N1 -n1 --container-name="${CONT_NAME}" nvidia-smi topo -m
echo "NCCL_TEST = ${NCCL_TEST}"
if [[ ${NCCL_TEST} -eq 1 ]]; then
    (srun --mpi="${SLURM_MPI_TYPE:-pmix}" --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
         --container-name="${CONT_NAME}" all_reduce_perf_mpi -b 21M -e 672M -d half -G 1 -f 2 ) |& tee "${LOGDIR}/${SPREFIX}_nccl.log"
fi
NODELIST=$(scontrol show hostnames ${SLURM_JOB_NODELIST})
NODELIST=(${NODELIST[*]})
k=0
if [ -f "$POWERCMDDIR/power_monitor.sh"  ]; then
    ( umask 0002; mkdir -p "${ABSLOGDIR}" )
    for i in "${NODELIST[@]}"
    do
      echo $i $k
	    if [[ "$((k++))" == '8' ]]; then
	      echo "Power log is being collected for 8 nodes only"
	      break
	    fi
      ssh $i 'export NODENAME='"'$i'"';export ABSLOGDIR='"'$ABSLOGDIR'"';export SLURM_JOB_NODELIST='"'$SLURM_JOB_NODELIST'"';export SLURM_JOB_ID='"'$SLURM_JOB_ID'"';POWERCMDDIR='"'$POWERCMDDIR'"';bash ${POWERCMDDIR}/power_monitor.sh' &
    done
fi
for _experiment_index in $(seq -w 1 "${NEXP}"); do
    (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
	echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST}"
	# TODO: ideally we should exchange seeds in the application (right before `build_train_valid_test_datasets`)
  # For now we can do this upfront by setting seeds here
  export SEED=$(($SEED_BASE - 1 + 10#$_experiment_index))  # `10#` makes sure we interpret number in base 10
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && ${DROPCACHE_CMD}"
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-name="${CONT_NAME}" python -c "
from mlperf_logger import mllogger
mllogger.event(key=mllogger.constants.CACHE_CLEAR, value=True)"
        fi
        # Run experiment
	srun --mpi="${SLURM_MPI_TYPE:-pmix}" --no-container-mount-home -l                                              \
	--ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
	--container-name="${CONT_NAME}" --container-mounts="${MOUNTS}"                 \
	--container-workdir=${WORK_DIR} ${SRUN_EXTRA_ARGS} "slurm2pytorch" "./run_and_time.sh"
    ) |& tee "${LOG_FILE_BASE}_${_experiment_index}.log"
    # compliance checker
    if [ "${CHECK_COMPLIANCE}" -eq 1 ]; then
      srun --ntasks=1 --nodes=1 --container-name="${CONT_NAME}" \
           --container-mounts="$(realpath ${LOGDIR}):/results"   \
           --container-workdir="/results"                        \
           python3 -m mlperf_logging.compliance_checker --usage training \
           --ruleset "${MLPERF_RULESET}"                                 \
           --log_output "/results/compliance_${DATESTAMP}.out"           \
           "/results/${LOG_BASE}_${_experiment_index}.log" \
    || true
    fi
done
