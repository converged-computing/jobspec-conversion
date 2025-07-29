#!/bin/bash
#SBATCH --job-name=single
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=80
#SBATCH --gres=gpu:8
#SBATCH --time=04:00:00
#SBATCH --exclusive
#SBATCH --constraint=gpu

export HDF5_USE_FILE_LOCKING='FALSE'

module load pytorch/v1.4.0-gpu
module list
export HDF5_USE_FILE_LOCKING=FALSE
srun python -m torch.distributed.launch --nproc_per_node=1 train.py --run_num=04 
date
