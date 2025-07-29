#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:4
#SBATCH --mem-per-cpu=64G
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

module load tensorflow
module list
set -xv
srun python3 $*
