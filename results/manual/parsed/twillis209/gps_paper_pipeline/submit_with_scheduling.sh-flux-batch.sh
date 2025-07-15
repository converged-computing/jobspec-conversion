#!/bin/bash
#FLUX: --job-name=sticky-hobbit-2854
#FLUX: -c=4
#FLUX: -t=21600
#FLUX: --priority=16

export OMP_NUM_THREADS='5'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-peta4            # REQUIRED - loads the basic environment
workdir="$SLURM_SUBMIT_DIR"
export OMP_NUM_THREADS=5
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
cd $workdir
echo -e "Changed directory to `pwd`.\n"
JOBID=$SLURM_JOB_ID
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on mcadr node: `hostname`"
echo "Current directory: `pwd`"
if [ "$SLURM_JOB_NODELIST" ]; then
        #! Create a machine file:
        export NODEFILE=`generate_pbs_nodefile`
        cat $NODEFILE | uniq > logs/machine.file.$JOBID
        echo -e "\nNodes allocated:\n================"
        echo `cat logs/machine.file.$JOBID | sed -e 's/\..*$//g'`
fi
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n\n"
__conda_setup="$('/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/rds/project/rds-csoP2nj6Y6Y/tw395/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup
unset R_LIBS
conda activate snakemake_env
snakemake --profile profile "${@}"
