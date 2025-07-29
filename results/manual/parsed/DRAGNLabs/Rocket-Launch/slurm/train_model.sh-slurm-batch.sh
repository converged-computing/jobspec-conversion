#!/bin/bash
#SBATCH --job-name=train_model
#SBATCH --output=%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --mem=512G
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=8

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
nvidia-smi
mamba activate rocket
srun python3 ../src/train.py ../configs/PATH_TO_CONFIG.yaml
