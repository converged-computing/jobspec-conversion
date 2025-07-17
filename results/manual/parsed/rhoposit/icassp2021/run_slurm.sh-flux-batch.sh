#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=ILCC_GPU
#FLUX: -t=7200
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=0,1,2,3
hostname
/usr/bin/nvidia-smi
. "/path/to/etc/profile.d/conda.sh"
conda activate project
python train.py -m sys3 -c 1000 --gpu_devices 0 1 2 3
python train.py -m sys5 -c 1000 -l checkpoints/sys5.43.upconv_xxxx.pyt --gpu_devices 0 1 2 3 
