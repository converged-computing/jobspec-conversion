#!/bin/bash
#FLUX: --job-name=outstanding-noodle-2144
#FLUX: -c=32
#FLUX: --priority=16

export MODEL_NAME='deepcam'
export MODEL_FRAMEWORK='pytorch'

set -euxo pipefail
: "${DGXSYSTEM:?DGXSYSTEM not set}"
: "${MLPERF_RULESET:=2.0.0}"
: "${DGXRUNNODES:=${SLURM_JOB_NUM_NODES}}"
: "${NEXP:=1}"
: "${NUM_INSTANCES:=1}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${LOGDIR:=$SCRATCH/optimized-hpc/deepcam/results/${SLURM_JOB_NAME}-${SLURM_JOB_ID}}"
: "${CUDNN_V8_API_ENABLED:=1}"
: "${NCCL_ASYNC_ERROR_HANDLING:=0}"
: "${NCCL_TEST:=1}"
: "${WIREUP_METHOD:=nccl-slurm}"
: "${ADDITIONAL_SRUN_ARGS:=""}"
TOTALGPU=$(( ${DGXRUNNODES} * ${DGXNGPU} ))
if [ "${TOTALGPU}" -eq 1 ]; then
    WIREUP_METHOD="dummy"
fi
export MODEL_NAME="deepcam"
export MODEL_FRAMEWORK="pytorch"
readonly _seed_override=${SEED:-}
readonly _logfile_base="${LOGDIR}/slurm_${DATESTAMP}"
readonly _cont_name="${MODEL_NAME}_${SLURM_JOB_ID}"
_cont_mounts="${DATADIR}:/data:ro;${LOGDIR}:/results" #;${STAGING_DIR}:/scratch"
mkdir -p "${LOGDIR}"
if [[ $NUM_INSTANCES -gt 1 ]]; then
    ## Clear caches
    #if [ "${CLEAR_CACHES}" -eq 1 ]; then
    #    srun --ntasks="${SLURM_JOB_NUM_NODES}" --mpi="${SLURM_MPI_TYPE:-pmix}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && ${DROPCACHE_CMD}"
    #fi
    JOB_NODES=$((SLURM_JOB_NUM_NODES / NUM_INSTANCES))
    seed=${_seed_override:-$(date +%s)}
    for _job_index in $(seq 1 "${NUM_INSTANCES}"); do
        export SEED=$((seed + _job_index))
        export EXP_ID=${_job_index}
        export DATESTAMP=${DATESTAMP}
        export WIREUP_METHOD=${WIREUP_METHOD}
        export NCCL_ASYNC_ERROR_HANDLING=${NCCL_ASYNC_ERROR_HANDLING}
	srun --wait=900 --kill-on-bad-exit=0 --mpi=pmi2 \
            --cpus-per-task=32 --cpu-bind=none ${ADDITIONAL_SRUN_ARGS} \
            -N "${JOB_NODES}" \
            --ntasks="$(( JOB_NODES * DGXNGPU ))" \
            --ntasks-per-node="${DGXNGPU}" \
            shifter --volume="${_cont_mounts}" --module gpu,nccl-2.18 \
	    bash ./run_and_time.sh &
        sleep 1
        logging_filename="${LOGDIR}/${DATESTAMP}_${EXP_ID}.log"
        ID=$(sacct -j $SLURM_JOB_ID --format JobID --parsable2 | tail -n 1)
        NNODES=$(sacct -j $SLURM_JOB_ID --format NNodes --parsable2 | tail -n 1)
        NODE_LIST=$(sacct -j $SLURM_JOB_ID --format NodeList%50 --parsable2 | tail -n 1)
        #echo ":::DLPAL ${CONT} ${ID} ${NNODES} ${NODE_LIST} ${MLPERF_CLUSTER_NAME} ${DGXSYSTEM}" >> $logging_filename
    done
    wait
else
    # Single-instance, time-to-train measurement jobs
    for _experiment_index in $(seq 1 "${NEXP}"); do
        (
	echo "Beginning trial ${_experiment_index} of ${NEXP}"
	#echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST} ${MLPERF_CLUSTER_NAME} ${DGXSYSTEM}"
	# Clear caches
	#if [ "${CLEAR_CACHES}" -eq 1 ]; then
	#    srun --ntasks="${SLURM_JOB_NUM_NODES}" --mpi="${SLURM_MPI_TYPE:-pmix}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && ${DROPCACHE_CMD}"
	#fi
	# Set Vars
	export SEED=${_seed_override:-$(date +%s)}
	export EXP_ID=${_experiment_index}
	export DATESTAMP=${DATESTAMP}
	export WIREUP_METHOD=${WIREUP_METHOD}
	export NCCL_ASYNC_ERROR_HANDLING=${NCCL_ASYNC_ERROR_HANDLING}
	# Run experiment
	srun --wait=900 --kill-on-bad-exit=0 --mpi=pmi2 \
             --cpus-per-task=32 --cpu-bind=none ${ADDITIONAL_SRUN_ARGS} \
	     -N "${DGXRUNNODES}" \
	     --ntasks="${TOTALGPU}" \
	     --ntasks-per-node="${DGXNGPU}" \
             shifter --volume="${_cont_mounts}" --module gpu,nccl-2.18 \
	     bash ./run_and_time.sh
        ) |& tee "${_logfile_base}_${_experiment_index}.log"
        # compliance checker
        #if [ "${CHECK_COMPLIANCE}" -eq 1 ]; then
        #  srun --ntasks=1 --nodes=1 --container-name="${_cont_name}" \
        #       --container-mounts="$(realpath ${LOGDIR}):/results"   \
        #       --container-workdir="/results"                        \
        #       python3 -m mlperf_logging.compliance_checker --usage hpc \
        #       --ruleset "${MLPERF_RULESET}"                                 \
        #       --log_output "/results/compliance_${DATESTAMP}_${_experiment_index}.out"           \
        #       "/results/slurm_${DATESTAMP}_${_experiment_index}.log" \
        # || true
        #fi
        #if [ "${JET:-0}" -eq 1 ]; then
        #  JET_CREATE=${JET_CREATE:-}" --data job_id=${SLURM_JOB_ID} --data pipeline_id=${CONT} --data workload.spec.nodes=${DGXNNODES} --data workload.spec.name=${MODEL_NAME}_${MODEL_FRAMEWORK}_${DGXSYSTEM} --data workload.key=${MODEL_NAME}_${MODEL_FRAMEWORK}_${DGXSYSTEM} --mllogger "
        #  srun -N1 -n1 --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" bash -c "${JET_CREATE} /results/slurm_${DATESTAMP}_${_experiment_index}.log && ${JET_UPLOAD}"
        #fi
    done
    wait
fi
