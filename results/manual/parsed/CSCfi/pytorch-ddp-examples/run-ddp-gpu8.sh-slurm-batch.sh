#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=0
#SBATCH --time=00:15:00
#SBATCH --constraint=ntasks-per-node=1

export RDZV_HOST='$(hostname)'
export RDZV_PORT='29400                   '

module purge
module load pytorch
export RDZV_HOST=$(hostname)
export RDZV_PORT=29400                   
srun torchrun \
    --nnodes=$SLURM_JOB_NUM_NODES \
    --nproc_per_node=4 \
    --rdzv_id=$SLURM_JOB_ID \
    --rdzv_backend=c10d \
    --rdzv_endpoint="$RDZV_HOST:$RDZV_PORT" \
    mnist_ddp.py --epochs=100
