#!/bin/bash
#FLUX: --job-name=hello-muffin-8523
#FLUX: -t=14400
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
port_number=$(shuf -i 29510-49510 -n 1)
echo Node IP: $head_node_ip
export LOGLEVEL=INFO
cd ..
source setup.sh
srun torchrun \
--nnodes 1 \
--nproc_per_node 4 \
--rdzv_id $RANDOM \
--rdzv_backend c10d \
--rdzv_endpoint $head_node_ip:$port_number \
evaluate.py $@
