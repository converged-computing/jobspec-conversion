#!/bin/bash
#SBATCH --job-name=cyclegan
#SBATCH --account=sds173
#SBATCH --output=pytorch-gpu-shared.o%j.%N
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=24

module purge
module list
printenv
time -p singularity exec --bind /oasis --nv /share/apps/gpu/singularity/images/pytorch/pytorch-v1.5.0-gpu-20200511.simg python3 main.py --dataroot /home/joeyli/projects/cyclegan/pytorch-CycleGAN-and-pix2pix/datasets/maps
