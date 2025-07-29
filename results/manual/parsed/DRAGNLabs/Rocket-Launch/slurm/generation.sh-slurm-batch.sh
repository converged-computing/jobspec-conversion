#!/bin/bash
#SBATCH --job-name=generation
#SBATCH --output=%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=128G
#SBATCH --time=01:00:00

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
nvidia-smi
mamba activate rocket
python3 ../src/generation.py ../configs/PATH_TO_CONFIG.yaml
