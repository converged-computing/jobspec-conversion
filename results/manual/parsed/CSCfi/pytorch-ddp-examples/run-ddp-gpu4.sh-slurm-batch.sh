#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=0
#SBATCH --time=00:15:00

module purge
module load pytorch
srun torchrun --standalone --nnodes=1 --nproc_per_node=4 mnist_ddp.py --epochs=100
