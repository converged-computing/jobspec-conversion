#!/bin/bash
#FLUX: --job-name=mlperft-hpc.deepcam-shmoo
#FLUX: --urgency=16

export MODEL_NAME='deepcam'
export MODEL_FRAMEWORK='pytorch'

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${CONT:?CONT not set}"
: "${MLPERF_RULESET:=2.0.0}"
: "${MLPERF_CLUSTER_NAME:='unknown'}"
: "${CHECK_COMPLIANCE:=1}"
: "${DGXRUNNODES:=${SLURM_JOB_NUM_NODES}}"
: "${NEXP:=1}"
: "${NUM_INSTANCES:=1}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${LOGDIR:=./results/shmoo}"
: "${ABSLOGDIR:=${PWD}/results/shmoo}"
: "${POWERCMDDIR:='/home/tkurth/optimized-hpc/mlperf_utils'}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
: "${CUDNN_V8_API_ENABLED:=1}"
: "${NCCL_ASYNC_ERROR_HANDLING:=0}"
: "${NCCL_TEST:=1}"
: "${NCCL_BISECT:=0}"
: "${WIREUP_METHOD:=nccl-slurm}"
: "${ADDITIONAL_SRUN_ARGS:=""}"
: "${COMP_CLOCK:=${BASE_COMP_CLOCK}}"
: "${MEM_CLOCK=${BASE_MEM_CLOCK}}"
: "${CLOCKFILE:=/home/tkurth/optimized-hpc/deepcam/pytorch/run_scripts/clocks/clocks_set_all.txt}"
: "${DROPCACHE_CMD:="sudo /sbin/sysctl vm.drop_caches=3"}"
TOTALGPU=$(( ${DGXRUNNODES} * ${DGXNGPU} ))
if [ "${TOTALGPU}" -eq 1 ]; then
    WIREUP_METHOD="dummy"
fi
cleanup_pyxis() {
    srun --ntasks="${SLURM_JOB_NUM_NODES}" /bin/bash -c 'if [[ "$(enroot list)" ]]; then enroot remove -f $(enroot list); fi'
}
trap cleanup_pyxis TERM EXIT
cleanup_pyxis
export MODEL_NAME="deepcam"
export MODEL_FRAMEWORK="pytorch"
readonly _seed_override=${SEED:-}
readonly _logfile_base="${LOGDIR}/slurm_${DATESTAMP}"
readonly _cont_name="${MODEL_NAME}_${SLURM_JOB_ID}"
_cont_mounts="${DATADIR}:/data:ro,${LOGDIR}:/results:rw,/raid/scratch:/scratch:rw"
SPREFIX="${MODEL_NAME}_${MODEL_FRAMEWORK}_${DGXNNODES}x${DGXNGPU}x${LOCAL_BATCH_SIZE}_${DATESTAMP}"
if [ "${API_LOGGING:-0}" -eq 1 ]; then
    API_LOG_DIR=${API_LOG_DIR}/${MODEL_FRAMEWORK}/${MODEL_NAME}/${DGXSYSTEM}
    mkdir -p ${API_LOG_DIR}
    _cont_mounts="${_cont_mounts},${API_LOG_DIR}:/logs"
    # Create JSON file for cuDNN
    JSON_MODEL_NAME="MLPERF_${MODEL_NAME}_${MODEL_FRAMEWORK}_train"
    JSON_README_LINK="${README_PREFIX}/${MODEL_NAME}/${MODEL_FRAMEWORK}/README.md"
    JSON_FMT='{model_name: $mn, readme_link: $rl, configs: {($dt): [$bs]}, sweep: {($dt): [$bs]}}'
    JSON_OUTPUT="${JSON_MODEL_NAME}.cudnn.json"
    jq -n --indent 4 --arg mn $JSON_MODEL_NAME --arg rl $JSON_README_LINK --arg dt $APILOG_PRECISION --arg bs $BATCHSIZE "$JSON_FMT" > ${API_LOG_DIR}/$JSON_OUTPUT
fi
if [ "${JET:-0}" -eq 1 ]; then
    _cont_mounts="${_cont_mounts},${JET_DIR}:/root/.jet"
fi
if [ "${ENABLE_GDS:-0}" == "1" ]; then
    echo "GDS enabled"
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
srun -N1 -n1 --container-name="${_cont_name}" --no-container-mount-home ibv_devinfo --list
srun -N1 -n1 --container-name="${_cont_name}" --no-container-mount-home nvidia-smi topo -m
srun --ntasks=1 --ntasks-per-node=1 --container-name="${_cont_name}" --no-container-mount-home bash -c "conda list; pip list"
echo "NCCL_TEST = ${NCCL_TEST}"
if [[ ${NCCL_TEST} -eq 1 ]]; then
    (srun --mpi="${SLURM_MPI_TYPE:-pmix}" --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
         --container-name="${_cont_name}" all_reduce_perf_mpi -b 210M -e 220M -d float -G 1 -f 2
) |& tee "${LOGDIR}/${SPREFIX}_nccl.log"
fi
if [ ${NCCL_BISECT} -eq 1 ] && [ "${SBATCH_NETWORK}" != "sharp" ]; then
    ./gpucommtest/gpucommtest.sh --stats --container-name="${_cont_name}"
fi
NODELIST=$(scontrol show hostnames ${SLURM_JOB_NODELIST})
NODELIST=(${NODELIST[*]})
if [ -f "$POWERCMDDIR/power_monitor.sh"  ]; then
    echo "Measuring Power"
    ( umask 0002; mkdir -p "${ABSLOGDIR}" )
    for i in "${NODELIST[@]}"
    do
        ssh $i 'export NODENAME='"'$i'"';export ABSLOGDIR='"'$ABSLOGDIR'"';export SLURM_JOB_NODELIST='"'$SLURM_JOB_NODELIST'"';export SLURM_JOB_ID='"'$SLURM_JOB_ID'"';POWERCMDDIR='"'$POWERCMDDIR'"';bash ${POWERCMDDIR}/power_monitor.sh' &
    done
fi
head -1 ${CLOCKFILE} |
while read -r gpu_id mem_freq aval_g_freqs; do
    echo "Beginning frequency shmoo"
    g_freq_arr=($aval_g_freqs)
    grp_start_idx=$((CLK_GROUP_SIZE * CLK_GROUP_IDX))
    for g_freq in ${g_freq_arr[@]:$grp_start_idx:$CLK_GROUP_SIZE}; do
        for i in "${NODELIST[@]}"
        do
            echo $i $g_freq
            ssh $i 'export GPCCLK='"'$g_freq'"';sudo nvidia-smi -lgc ${GPCCLK}'
        done
        #avoid thermal issues
        sleep 300
        # Run experiments
	if [[ $NUM_INSTANCES -gt 1 ]]  # Launch weak scaling jobs
	then
            # Clear caches
            if [ "${CLEAR_CACHES}" -eq 1 ]; then
		srun --ntasks="${SLURM_JOB_NUM_NODES}" --mpi="${SLURM_MPI_TYPE:-pmix}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && ${DROPCACHE_CMD}"
            fi
            JOB_NODES=$((SLURM_JOB_NUM_NODES / NUM_INSTANCES))
            seed=${_seed_override:-$(date +%s)}
            for _job_index in $(seq 1 "${NUM_INSTANCES}"); do
		export SEED=$((seed + _job_index))
		export EXP_ID=${_job_index}_${COMP_CLOCK}
		export DATESTAMP=${DATESTAMP}
		export WIREUP_METHOD=${WIREUP_METHOD}
		export NCCL_ASYNC_ERROR_HANDLING=${NCCL_ASYNC_ERROR_HANDLING}
		srun --wait=900 --kill-on-bad-exit=0 --mpi="${SLURM_MPI_TYPE:-pmix}" ${ADDITIONAL_SRUN_ARGS} \
                     -N "${JOB_NODES}" \
                     --ntasks="$(( JOB_NODES * DGXNGPU ))" \
                     --ntasks-per-node="${DGXNGPU}" \
                     --no-container-mount-home \
                     --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" \
                     --container-workdir /workspace \
                     bash ./run_and_time.sh &
            done
            wait
	else  # Strong scaling
	    # Run experiments
	    for _experiment_index in $(seq 1 "${NEXP}"); do
		(
		    echo "Beginning trial ${_experiment_index} of ${NEXP}"
		    echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST} ${MLPERF_CLUSTER_NAME} ${DGXSYSTEM}"
		    # Clear caches
		    if [ "${CLEAR_CACHES}" -eq 1 ]; then
			srun --ntasks="${SLURM_JOB_NUM_NODES}" --mpi="${SLURM_MPI_TYPE:-pmix}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && ${DROPCACHE_CMD}"
		    fi
		    # Set Vars
		    export SEED=${_seed_override:-$(date +%s)}
		    export EXP_ID=${_experiment_index}_${COMP_CLOCK}
		    export DATESTAMP=${DATESTAMP}
		    export WIREUP_METHOD=${WIREUP_METHOD}
		    export NCCL_ASYNC_ERROR_HANDLING=${NCCL_ASYNC_ERROR_HANDLING}
		    # Run experiment
		    srun --wait=900 --kill-on-bad-exit=0 --mpi="${SLURM_MPI_TYPE:-pmix}" ${ADDITIONAL_SRUN_ARGS} \
			 -N "${DGXRUNNODES}" \
			 --ntasks="${TOTALGPU}" \
			 --ntasks-per-node="${DGXNGPU}" \
			 --no-container-mount-home \
			 --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" \
			 --container-workdir /workspace \
			 bash ./run_and_time.sh
		) |& tee "${_logfile_base}_${_experiment_index}_${COMP_CLOCK}.log"
		# compliance checker
		if [ "${CHECK_COMPLIANCE}" -eq 1 ]; then
		    srun --ntasks=1 --nodes=1 --container-name="${_cont_name}" \
			 --container-mounts="$(realpath ${LOGDIR}):/results"   \
			 --container-workdir="/results"                        \
			 python3 -m mlperf_logging.compliance_checker --usage hpc \
			 --ruleset "${MLPERF_RULESET}"                                 \
			 --log_output "/results/compliance_${DATESTAMP}_${_experiment_index}_${COMP_CLOCK}.out" \
			 "/results/slurm_${DATESTAMP}_${_experiment_index}_${COMP_CLOCK}.log" \
			|| true
		fi
		if [ "${JET:-0}" -eq 1 ]; then
		    JET_CREATE=${JET_CREATE:-}" --data workload.spec.nodes=${DGXNNODES} --data workload.spec.name=${MODEL_NAME}_${MODEL_FRAMEWORK}_${DGXSYSTEM} --data workload.key=${MODEL_NAME}_${MODEL_FRAMEWORK}_${DGXSYSTEM} --mllogger "
		    srun -N1 -n1 --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" bash -c "${JET_CREATE} /results/slurm_${DATESTAMP}_${_experiment_index}_${COMP_CLOCK}.log && ${JET_UPLOAD}"
		fi
	    done
	    wait
	fi
    done
done
