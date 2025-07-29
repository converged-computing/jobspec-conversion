#!/bin/bash
#SBATCH --job-name=pyg-multinode-tutorial
#SBATCH --output=pyg-multinode.log
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=100G
#SBATCH --partition=gpucloud

export MASTER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'

export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
echo "MASTER_ADDR:MASTER_PORT="${MASTER_ADDR}:${MASTER_PORT}
echo "###########################################################################"
echo "We recommend you set up your environment here (conda/spack/pip/modulefiles)"
echo "then remove --export=ALL (allows running the sbatch from any shell"
echo "###########################################################################"
srun --output=0 python distributed_sampling_multinode.py
