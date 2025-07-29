#!/bin/bash
#SBATCH --account=project_2003959
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:2
#SBATCH --mem-per-cpu=64G
#SBATCH --time=01:00:00

export DATADIR='/scratch/project_2003959/data'
export KERAS_HOME='/scratch/project_2003959/keras-cache'

module load tensorflow/nvidia-20.07-tf2-py3
module list
export DATADIR=/scratch/project_2003959/data
export KERAS_HOME=/scratch/project_2003959/keras-cache
set -xv
srun python3 $*
