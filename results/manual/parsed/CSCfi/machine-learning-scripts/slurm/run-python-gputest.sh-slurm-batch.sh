#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:1
#SBATCH --mem=8G
#SBATCH --time=00:15:00

module load python-env/3.6.3-ml
module list
set -xv
date
hostname
nvidia-smi
srun python3.6 $*
date
