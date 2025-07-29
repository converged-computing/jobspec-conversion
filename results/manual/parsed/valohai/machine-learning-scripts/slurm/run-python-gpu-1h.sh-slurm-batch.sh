#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:1
#SBATCH --mem=4G
#SBATCH --time=01:00:00

module list
set -xv
date
hostname
nvidia-smi
srun python3.5 $*
date
