#!/bin/bash
#FLUX: --job-name=cyclegan
#FLUX: --queue=gpu
#FLUX: -t=1200
#FLUX: --urgency=16

module purge
module list
printenv
time -p singularity exec --bind /oasis --nv /share/apps/gpu/singularity/images/tensorflow/tensorflow-v1.15.2-gpu-20200318.simg python3 main.py --data /home/joeyli/projects/cyclegan/pytorch-CycleGAN-and-pix2pix/datasets/maps --gpu_ids 0,1 --batch_size 16 --norm instance --continue_train
