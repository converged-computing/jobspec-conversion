#!/bin/bash
#SBATCH --job-name=multi8
#SBATCH --account=m1759
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=80
#SBATCH --gres=gpu:8
#SBATCH --time=08:00:00
#SBATCH --exclusive
#SBATCH --constraint=gpu

export HDF5_USE_FILE_LOCKING='FALSE'

module load pytorch/v1.4.0-gpu
export HDF5_USE_FILE_LOCKING=FALSE
srun python -m torch.distributed.launch --nproc_per_node=8 train.py --run_num=14 --config=multi8
date
