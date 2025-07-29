#!/bin/bash
#FLUX: --job-name=mlperf-hpc:deepcam
#FLUX: -N=32
#FLUX: -n=128
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module load shared
module load slurm
module load shared openmpi/4.1.2
module list
set -euxo pipefail
GPU_TYPE=$( nvidia-smi -L | awk '{ print $4 }'| head -n 1 )
source configs/config_${SLURM_JOB_NUM_NODES}xXE8545x4${GPU_TYPE}.sh
echo source configs/config_${SLURM_JOB_NUM_NODES}xXE8545x4${GPU_TYPE}.sh
CONT="/mnt/data/deepcam_20220829.sif"
: "${LOGDIR:=/home/frank/results/deepcam-2.0/${SLURM_JOB_NUM_NODES}XE8545-4x${GPU_TYPE}}}"
: "${NEXP:=10}"
: "${DATADIR:=/share/deepcam/npy}"
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${DGXRUNNODES:=${SLURM_JOB_NUM_NODES}}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
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
_cont_mounts="${DATADIR}:/data:ro,${LOGDIR}:/results:rw,/mnt/data/scratch:/scratch:rw"
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
	hosts=$(scontrol show hostname |tr "\n" " ")
        echo "hosts=$hosts"
        #for node_id in `seq 0 $(($NUM_NODES-1))`; do
        for node in $hosts; do
	# Clear caches
	if [ "${CLEAR_CACHES}" -eq 1 ]; then
	   #srun --ntasks="${SLURM_JOB_NUM_NODES}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
           srun -N 1 -n 1 -w $node bash -c "echo -n 'Clearing cache on ' && hostname && sync && sudo /sbin/sysctl vm.drop_caches=3"
sleep 1
	fi
	done
	# Set Vars
	export SEED=${_seed_override:-$(date +%s)}
	export EXP_ID=${_experiment_index}
	export DATESTAMP=${DATESTAMP}
	export WIREUP_METHOD=${WIREUP_METHOD}
	export NCCL_ASYNC_ERROR_HANDLING=${NCCL_ASYNC_ERROR_HANDLING}
	# Run experiment
CONT_MOUNTS="${_cont_mounts}"
echo CONT_MOUNTS="${_cont_mounts}"
        #srun -l --wait=900 --kill-on-bad-exit=0 --ntasks=${SLURM_NTASKS}  --ntasks-per-node=${DGXNGPU} \
        srun -l --wait=900 --kill-on-bad-exit=0 --mpi=pmix --ntasks=${SLURM_NTASKS}  --ntasks-per-node=${DGXNGPU} \
           singularity exec --nv -B "${CONT_MOUNTS}" \
             -B $PWD:/workspace --pwd /workspace \
             $CONT  ./run_and_time_multi.sh
    ) |& tee "${_logfile_base}_${_experiment_index}.out"
done
wait
