#!/bin/bash
#FLUX: --job-name=spicy-butter-1524
#FLUX: -N=10
#FLUX: -n=10
#FLUX: -t=129600
#FLUX: --urgency=16

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load default-impi                   # REQUIRED - loads the basic environment
module load samtools-1.4-gcc-5.4.0-derfxbk
application=""
options=""
:
conda activate py37
snakemake -j10 
