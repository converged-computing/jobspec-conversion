#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64G
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

module load tensorflow/2.0.0
module list
set -xv
srun python3.7 $*
