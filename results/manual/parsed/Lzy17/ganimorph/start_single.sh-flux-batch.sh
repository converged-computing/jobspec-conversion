#!/bin/bash
#FLUX: --job-name=cyclegan
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module list
printenv
time -p singularity exec --bind /oasis --nv /share/apps/gpu/singularity/images/pytorch/pytorch-v1.5.0-gpu-20200511.simg python3 main.py --dataroot /home/joeyli/projects/cyclegan/pytorch-CycleGAN-and-pix2pix/datasets/maps
