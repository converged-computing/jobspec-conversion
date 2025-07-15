#!/bin/bash
#FLUX: --job-name=dirty-cattywampus-8698
#FLUX: -N=15
#FLUX: -c=2
#FLUX: --urgency=16

if [[ "${AWS_BATCH_JOB_NODE_INDEX}" -eq  "${AWS_BATCH_JOB_MAIN_NODE_INDEX}" ]]; then
    echo "Hello I'm the main node $HOSTNAME! I run the mpi job!"
    echo "Running..."
    module load ${MPI_MODULE}
    EPIRUST_CONFIG_NAME="1m_100"
    CURRENT_DATE=$(date -u | sed -r 's/ +/::/g')
    SHARED_DIR=/home/ubuntu
    EPIRUST_OUTPUT_DIR=${SHARED_DIR}/${EPIRUST_CONFIG_NAME}_${CURRENT_DATE}
    mkdir -p ${EPIRUST_OUTPUT_DIR}
    EPIRUST_CONFIG=${SHARED_DIR}/epirust/engine/config/${EPIRUST_CONFIG_NAME}.json
    echo "Running ${EPIRUST_CONFIG}"
    echo "Nodelist: $SLURM_JOB_NODELIST"
    echo "CoerPerTask: $SLURM_CPUS_PER_TASK"
    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
    mpirun --map-by core --mca btl_tcp_if_include ens5 --mca orte_base_help_aggregate 0 --allow-run-as-root -n ${SLURM_NTASKS}  -x RUST_BACKTRACE=full ${SHARED_DIR}/epirust/target/release/engine-app -m mpi -c ${EPIRUST_CONFIG} -o ${EPIRUST_OUTPUT_DIR} -t ${SLURM_CPUS_PER_TASK}
    # Write exit status code
    echo "0" > "${_exit_code_file}"
    # Waiting for compute nodes to terminate
    sleep 30
else
    echo "Hello I'm the compute node $HOSTNAME! I let the main node orchestrate the mpi processing!"
    sleep 5
    echo $(ls -la "${_job_dir}")
    # Since mpi orchestration happens on the main node, we need to make sure the containers representing the compute
    # nodes are not terminated. A simple trick is to wait for a file containing the status code to be created.
    # All compute nodes are terminated by AWS Batch if the main node exits abruptly.
    while [ ! -f "${_exit_code_file}" ]; do
        sleep 2
    done
    exit $(cat "${_exit_code_file}")
fi
