#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=12:00:00
#SBATCH --qos=short
#SBATCH --exclude=gpu[0-6]

export HDF5_USE_FILE_LOCKING='FALSE'

source /etc/profile
module unload cuda
module load cuda/11.1
source .venv/bin/activate
export HDF5_USE_FILE_LOCKING=FALSE
wandb agent --count 1 "$@"
