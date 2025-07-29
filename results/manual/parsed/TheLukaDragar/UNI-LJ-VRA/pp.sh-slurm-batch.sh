#!/bin/bash
#SBATCH --job-name=seqtrain
#SBATCH --output=slurm-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --mem=0
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=2

export WANDB__SERVICE_WAIT='300'

source ~/miniconda3/etc/profile.d/conda.sh
conda activate pytorch_env
export WANDB__SERVICE_WAIT=300
srun python train_convnext_SequecingWithzaporednimifrmi2nodes.py 
