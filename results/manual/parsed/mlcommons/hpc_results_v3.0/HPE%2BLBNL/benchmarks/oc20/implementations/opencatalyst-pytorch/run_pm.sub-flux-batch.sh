#!/bin/bash
#FLUX: --job-name=persnickety-puppy-9665
#FLUX: --urgency=16

export MODEL_NAME='oc20'
export MODEL_FRAMEWORK='pytorch'

set -euxo pipefail
: "${MLPERF_RULESET:=2.0.0}"
: "${DGXNGPU:=4}"
: "${NEXP:=1}"
: "${NCCL_TEST:=1}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${LOGDIR:=$SCRATCH/optimized-hpc/opencatalyst/results/${SLURM_JOB_NAME}-${SLURM_JOB_ID}}"
export MODEL_NAME="oc20"
export MODEL_FRAMEWORK="pytorch"
readonly _seed_override=${SEED:-}
readonly _logfile_base="${LOGDIR}/slurm_${DATESTAMP}"
readonly _cont_name="${MODEL_NAME}_${SLURM_JOB_ID}"
_cont_mounts="${DATADIR}:/data:ro;${LOGDIR}:/results"
mkdir -p "${LOGDIR}"
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
	# Run experiment
	srun -l --kill-on-bad-exit=1 --mpi=pmi2 \
            --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" \
            --ntasks-per-node="${DGXNGPU}" \
            --cpus-per-task=32 --cpu-bind=none \
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
