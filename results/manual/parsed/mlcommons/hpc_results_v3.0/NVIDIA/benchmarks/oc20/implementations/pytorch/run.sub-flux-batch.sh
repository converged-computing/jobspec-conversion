#!/bin/bash
#FLUX: --job-name=mlperf-hpc:oc20
#FLUX: --urgency=16

export MODEL_NAME='oc20'
export MODEL_FRAMEWORK='pytorch'

set -euxo pipefail
: "${CONT:?CONT not set}"
: "${MLPERF_RULESET:=3.0.0}"
: "${MLPERF_CLUSTER_NAME:='unknown'}"
: "${CHECK_COMPLIANCE:=1}"
: "${DGXSYSTEM:=DGXA100}"
: "${DGXNGPU:=8}"
: "${NEXP:=1}"
: "${NUM_INSTANCES:=1}"
: "${NCCL_TEST:=1}"
: "${DATESTAMP:=$(date +'%y%m%d%H%M%S%N')}"
: "${CLEAR_CACHES:=1}"
: "${LOGDIR:=./results}"
: "${ABSLOGDIR:=${PWD}/results}"
: "${POWERCMDDIR:=' '}"
: "${API_LOG_DIR:=./api_logs}" # apiLog.sh output dir
: "${DROPCACHE_CMD:="sudo /sbin/sysctl vm.drop_caches=3"}"
cleanup_pyxis() {
    srun --ntasks="${SLURM_JOB_NUM_NODES}" /bin/bash -c 'if [[ "$(enroot list)" ]]; then enroot remove -f $(enroot list); fi'
}
trap cleanup_pyxis TERM EXIT
cleanup_pyxis
export MODEL_NAME="oc20"
export MODEL_FRAMEWORK="pytorch"
readonly _seed_override=${SEED:-}
readonly _logfile_base="${LOGDIR}/slurm_${DATESTAMP}"
readonly _cont_name="${MODEL_NAME}_${SLURM_JOB_ID}"
_cont_mounts="${DATADIR}:/data:ro,${LOGDIR}:/results:rw"
SPREFIX="${MODEL_NAME}_${MODEL_FRAMEWORK}_${DGXNNODES}x${DGXNGPU}x${BATCH_SIZE}_${DATESTAMP}"
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
MLPERF_HOST_OS=$(srun -N1 -n1 bash <<EOF
		 source /etc/os-release
		 source /etc/dgx-release || true
		 echo "\${PRETTY_NAME} / \${DGX_PRETTY_NAME:-???} \${DGX_OTA_VERSION:-\${DGX_SWBUILD_VERSION:-???}}"
EOF
)
export MLPERF_HOST_OS
( umask 0002; mkdir -p "${LOGDIR}" )
srun --ntasks="${SLURM_JOB_NUM_NODES}" mkdir -p "${LOGDIR}"
srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-image="${CONT}" --container-name="${_cont_name}" true
echo "NCCL_TEST = ${NCCL_TEST}"
if [[ ${NCCL_TEST} -eq 1 ]]; then
    (srun --mpi="${SLURM_MPI_TYPE:-pmix}" --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
         --container-name="${_cont_name}" all_reduce_perf_mpi -b 3542K -e 3542K -d half -G 1 -f 2
) |& tee "${LOGDIR}/${SPREFIX}_nccl.log"
fi
NODELIST=$(scontrol show hostnames ${SLURM_JOB_NODELIST})
NODELIST=(${NODELIST[*]})
if [ -f "$POWERCMDDIR/power_monitor.sh"  ]; then
    ( umask 0002; mkdir -p "${ABSLOGDIR}" )
    for i in "${NODELIST[@]}"
    do
        ssh $i 'export NODENAME='"'$i'"';export ABSLOGDIR='"'$ABSLOGDIR'"';export SLURM_JOB_NODELIST='"'$SLURM_JOB_NODELIST'"';export SLURM_JOB_ID='"'$SLURM_JOB_ID'"';POWERCMDDIR='"'$POWERCMDDIR'"';bash ${POWERCMDDIR}/power_monitor.sh' &
    done
fi
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
            export EXP_ID=${_job_index}
            export DATESTAMP=${DATESTAMP}
            NUM_INSTANCES=1 THROUGPUT_RUN=1 srun -l --kill-on-bad-exit=0 --mpi="${SLURM_MPI_TYPE:-pmix}" --nodes="${JOB_NODES}" --ntasks="$(( JOB_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
                --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" \
                bash ./run_and_time.sh &
            sleep 1
            logging_filename="${LOGDIR}/${DATESTAMP}_${EXP_ID}.log"
            ID=$(sacct -j $SLURM_JOB_ID --format JobID --parsable2 | tail -n 1)
            NNODES=$(sacct -j $SLURM_JOB_ID --format NNodes --parsable2 | tail -n 1)
            NODE_LIST=$(sacct -j $SLURM_JOB_ID --format NodeList%50 --parsable2 | tail -n 1)
            echo ":::DLPAL ${CONT} ${ID} ${NNODES} ${NODE_LIST} ${MLPERF_CLUSTER_NAME} ${DGXSYSTEM}" >> $logging_filename
        done
        wait
else  # Strong scaling
    for _experiment_index in $(seq 1 "${NEXP}"); do
        (
        echo "Beginning trial ${_experiment_index} of ${NEXP}"
        echo ":::DLPAL ${CONT} ${SLURM_JOB_ID} ${SLURM_JOB_NUM_NODES} ${SLURM_JOB_NODELIST} ${MLPERF_CLUSTER_NAME} ${DGXSYSTEM}"
        # Set Vars
        export SEED=${_seed_override:-$(date +%s)}
        export EXP_ID=${_experiment_index}
        export DATESTAMP=${DATESTAMP}
        # Clear caches
        if [ "${CLEAR_CACHES}" -eq 1 ]; then
            srun --ntasks="${SLURM_JOB_NUM_NODES}" --mpi="${SLURM_MPI_TYPE:-pmix}" bash -c "echo -n 'Clearing cache on ' && hostname && sync && ${DROPCACHE_CMD}"
        fi
        # Run experiment
        srun -l --kill-on-bad-exit=0 --mpi="${SLURM_MPI_TYPE:-pmix}" --ntasks="$(( SLURM_JOB_NUM_NODES * DGXNGPU ))" --ntasks-per-node="${DGXNGPU}" \
            --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" \
            bash ./run_and_time.sh
        ) |& tee "${_logfile_base}_${_experiment_index}.log"
        # compliance checker
        if [ "${CHECK_COMPLIANCE}" -eq 1 ]; then
            srun --ntasks=1 --nodes=1 --container-name="${_cont_name}" \
                --container-mounts="$(realpath ${LOGDIR}):/results"   \
                --container-workdir="/results"                        \
                python3 -m mlperf_logging.compliance_checker --usage hpc \
                --ruleset "${MLPERF_RULESET}"                                 \
                --log_output "/results/compliance_${DATESTAMP}_${_experiment_index}.out"           \
                "/results/slurm_${DATESTAMP}_${_experiment_index}.log" \
            || true
        fi
    if [ "${JET:-0}" -eq 1 ]; then
      JET_CREATE=${JET_CREATE:-}" --data workload.spec.nodes=${DGXNNODES} --data workload.spec.name=${MODEL_NAME}_${MODEL_FRAMEWORK}_${DGXSYSTEM} --data workload.key=${MODEL_NAME}_${MODEL_FRAMEWORK}_${DGXSYSTEM} --mllogger "
      srun -N1 -n1 --container-name="${_cont_name}" --container-mounts="${_cont_mounts}" bash -c "${JET_CREATE} /results/slurm_${DATESTAMP}_${_experiment_index}.log && ${JET_UPLOAD}"
    fi
    done
    wait
fi
