#!/bin/bash
#SBATCH --job-name=ddp-torch
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:2
#SBATCH --mem=64G
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=2

export MASTER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export WORLD_SIZE='$SLURM_NPROCS'
export MASTER_ADDR='$master_addr'

export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
echo "MASTER_PORT="$MASTER_PORT
export WORLD_SIZE=$SLURM_NPROCS
echo "WORLD_SIZE="$WORLD_SIZE
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
source $STORE/mypython/bin/deactivate
source $STORE/mypython/bin/activate
srun ./mnist_classify_ddp.sh
