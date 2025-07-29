#!/bin/bash
#SBATCH --account=project_2003959
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:1,nvme:100
#SBATCH --mem=64G
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

export DATADIR='$LOCAL_SCRATCH'

module load tensorflow/nvidia-20.07-tf2-py3
module list
export DATADIR=$LOCAL_SCRATCH
set -xv
tar xf /scratch/project_2003959/data/dogs-vs-cats.tar -C $LOCAL_SCRATCH
python3 $*
