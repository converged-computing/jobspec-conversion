#!/bin/bash
#SBATCH --account=m1759
#SBATCH --output=sout/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=gpu,ntasks-per-node=1

nproc_per_node=1
config=bs128-opt
module load cgpu
module load pytorch/1.7.0-gpu
srun -N 1 -n 1 python -m torch.distributed.launch --nproc_per_node=$nproc_per_node \
    train.py --config=$config
