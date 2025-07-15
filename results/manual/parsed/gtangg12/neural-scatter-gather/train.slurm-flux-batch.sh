#!/bin/bash
#FLUX: --job-name=stanky-gato-1536
#FLUX: --exclusive
#FLUX: -t=86400
#FLUX: --priority=16

export NODELIST='nodelist.$'
export HOROVOD_GPU_ALLREDUCE='MPI'
export HOROVOD_GPU_ALLGATHER='MPI'
export HOROVOD_GPU_BROADCAST='MPI'
export NCCL_DEBUG='DEBUG'

HOME2=/nobackup/users/$(whoami)
PYTHON_VIRTUAL_ENVIRONMENT=ml
CONDA_ROOT=$HOME2/anaconda3
source ${CONDA_ROOT}/etc/profile.d/conda.sh
conda activate $PYTHON_VIRTUAL_ENVIRONMENT
ulimit -s unlimited
export NODELIST=nodelist.$
srun -l bash -c 'hostname' |  sort -k 2 -u | awk -vORS=, '{print $2":4"}' | sed 's/,$//' > $NODELIST
echo " "
echo " Nodelist:= " $SLURM_JOB_NODELIST
echo " Number of nodes:= " $SLURM_JOB_NUM_NODES
echo " GPUs per node:= " $SLURM_JOB_GPUS
echo " Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
export HOROVOD_GPU_ALLREDUCE=MPI
export HOROVOD_GPU_ALLGATHER=MPI
export HOROVOD_GPU_BROADCAST=MPI
export NCCL_DEBUG=DEBUG
echo " Running on multiple nodes/GPU devices"
echo ""
echo " Run started at:- "
date
horovodrun -np $SLURM_NTASKS -H `cat $NODELIST` python /nobackup/users/gtangg12/neural_scatter_gather/train.py
echo "Run completed at:- "
date
