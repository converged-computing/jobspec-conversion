#!/bin/bash
#FLUX: --job-name=purple-leopard-7430
#FLUX: -c=10
#FLUX: --urgency=16

config=$1
echo $(scontrol show hostnames $SLURM_JOB_NODELIST)
source ~/.bashrc
conda activate graph-aug
echo CUDA_VISIBLE_DEVICES $CUDA_VISIBLE_DEVICES
echo "python main.py --configs $config --num_workers 8 --devices $CUDA_VISIBLE_DEVICES"
CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES python main.py --configs $config --num_workers 8 --devices $CUDA_VISIBLE_DEVICES
