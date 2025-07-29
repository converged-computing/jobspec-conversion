#!/bin/bash
#FLUX: --job-name=mlperf-hpc:deepcam
#FLUX: --urgency=16

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${DGXRUNNODES:=${SLURM_JOB_NUM_NODES}}"
: "${NEXP:=1}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${LOGDIR:=./results}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
: "${CUDNN_V8_API_ENABLED:=1}"
: "${NCCL_ASYNC_ERROR_HANDLING:=0}"
: "${NCCL_TEST:=0}"
: "${NCCL_BISECT:=0}"
: "${WIREUP_METHOD:=nccl-slurm}"
TOTALGPU=$(( ${DGXRUNNODES} * ${DGXNGPU} ))
if [ "${TOTALGPU}" -eq 1 ]; then
    WIREUP_METHOD="dummy"
fi
readonly _seed_override=${SEED:-}
readonly _logfile_base="${LOGDIR}/slurm_${DATESTAMP}"
readonly _cont_name=mlperf-hpc-deepcam
_cont_mounts="${DATADIR}:/data:ro,${LOGDIR}:/results:rw,/raid/scratch:/scratch:rw"
if [ "${API_LOGGING:-0}" -eq 1 ]; then
    _cont_mounts="${_cont_mounts},${API_LOG_DIR}:/logs"
fi
if [ "${ENABLE_GDS:-0}" == "1" ]; then
    _cont_mounts="${_cont_mounts},/run/udev:/run/udev:ro"
fi
if [ "${SBATCH_NETWORK:-}" == "sharp" ]; then
    echo "Using SHARP"
    #export SHARP_COLL_LOCK_ON_COMM_INIT=1
    #export SHARP_COLL_NUM_COLL_GROUP_RESOURCE_ALLOC_THRESHOLD=0
    #export SHARP_COLL_ENABLE_SAT=1
    #export NCCL_COLLNET_ENABLE=1
    #export SHARP_COLL_SHARPD_SOCKET_NAME=sharpd_hpcx_2.4.2
    if [ "${SHARP_DEBUG:-0}" -eq 1 ]; then
	export SHARP_COLL_LOG_LEVEL=3
	export NCCL_DEBUG=info
    fi
fi
MLPERF_HOST_OS=$(srun -N1 -n1 bash <<EOF
		 source /etc/os-release
		 source /etc/dgx-release || true
		 echo "\${PRETTY_NAME} / \${DGX_PRETTY_NAME:-???} \${DGX_OTA_VERSION:-\${DGX_SWBUILD_VERSION:-???}}"
EOF
)
export MLPERF_HOST_OS
( umask 0002; mkdir -p "${LOGDIR}" )
srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-image="${CONT}" --container-name="${_cont_name}" true
srun --ntasks=1 --ntasks-per-node=1 --container-name="${_cont_name}" --no-container-mount-home bash -c "conda list; pip list"
if [ ${NCCL_TEST} -eq 1 ]; then
    srun --mpi=pmix \
	 -N "${DGXRUNNODES}" \
	 --ntasks="${TOTALGPU}" \
	 --ntasks-per-node="${DGXNGPU}" \
	 --container-name="${_cont_name}" all_reduce_perf_mpi -b 21M -e 270M -d float -G 1 -f 2
fi
if [ ${NCCL_BISECT} -eq 1 ] && [ "${SBATCH_NETWORK}" != "sharp" ]; then
    ./gpucommtest/gpucommtest.sh --stats --container-name="${_cont_name}"
fi
for _experiment_index in $(seq 1 "${NEXP}"); do
    (
	echo "Beginning trial ${_experiment_index} of ${NEXP}"
	# Clear caches
	if [ "${CLEAR_CACHES}" -eq 1 ]; then
	    srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
	fi
	# Set Vars
	export SEED=${_seed_override:-$(date +%s)}
	export EXP_ID=${_experiment_index}
	export DATESTAMP=${DATESTAMP}
	export WIREUP_METHOD=${WIREUP_METHOD}
	export NCCL_ASYNC_ERROR_HANDLING=${NCCL_ASYNC_ERROR_HANDLING}
	# Run experiment
	srun -l --wait=900 --kill-on-bad-exit=0 --mpi=pmix \
	     -N "${DGXRUNNODES}" \
	     --ntasks="${TOTALGPU}" \
	     --ntasks-per-node="${DGXNGPU}" \
	     --no-container-mount-home \
	     --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" \
	     --container-workdir /workspace \
	     bash ./run_and_time.sh
    ) |& tee "${_logfile_base}_${_experiment_index}.out"
done
wait
