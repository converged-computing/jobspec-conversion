#!/bin/bash
#FLUX: --job-name=expensive-peas-5416
#FLUX: -n=4
#FLUX: -t=7200
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
application=""
options=""
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
CMD="$application $options"
