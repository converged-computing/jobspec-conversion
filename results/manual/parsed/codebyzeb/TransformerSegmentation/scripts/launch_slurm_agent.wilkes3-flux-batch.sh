#!/bin/bash
#FLUX: --job-name=buttery-leg-3880
#FLUX: -t=10800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export LOGLEVEL='INFO'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
JOBID=$SLURM_JOB_ID
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
cd ..
source setup.sh
wandb agent $1 --count 1
