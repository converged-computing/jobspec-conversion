#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:a100:1
#SBATCH --time=01:00:00
#SBATCH --partition=gpusmall

module load tensorflow/2.4
module list
set -xv
srun python3 $*
