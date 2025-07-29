#!/bin/bash
#SBATCH --job-name=pytorch
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=dcu:4
#SBATCH --mem-per-cpu=80G
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=4

python  -m torch.distributed.launch --nproc_per_node=4 ddp_train_coco.py 
