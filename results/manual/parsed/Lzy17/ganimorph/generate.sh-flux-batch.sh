#!/bin/bash
#FLUX: --job-name=cyclegan
#FLUX: -N=4
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module list
printenv
time -p singularity exec --bind /oasis --nv /share/apps/gpu/singularity/images/pytorch/pytorch-v1.5.0-gpu-20200511.simg python3 test.py --dataroot ./datasets/maps --name maps_cyclegan --model cycle_gan --gpu_ids 0,1,2,3 --batch_size 16 --norm instance
