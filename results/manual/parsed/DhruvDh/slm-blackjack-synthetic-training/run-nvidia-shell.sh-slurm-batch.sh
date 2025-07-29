#!/bin/bash
#SBATCH --job-name=test-nvidia
#SBATCH --output=test-nvidia.out
#SBATCH --error=test-nvidia.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A40:1
#SBATCH --mem=48G
#SBATCH --time=01:00:00
#SBATCH --partition=GPU
#SBATCH --constraint=ntasks-per-node=1

module load singularity
srun --pty singularity shell --nv nvidia.sif
