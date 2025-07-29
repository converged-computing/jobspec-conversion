#!/bin/bash
#SBATCH --job-name=cyclegan
#SBATCH --account=sds173
#SBATCH --output=tf-gpu.o%j.%N
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=16

module purge
module list
printenv
time -p singularity exec --bind /oasis --nv /share/apps/gpu/singularity/images/tensorflow/tensorflow-v1.15.2-gpu-20200318.simg python3 main.py --data /home/joeyli/projects/cyclegan/pytorch-CycleGAN-and-pix2pix/datasets/maps --gpu_ids 0,1 --batch_size 16 --norm instance --continue_train
