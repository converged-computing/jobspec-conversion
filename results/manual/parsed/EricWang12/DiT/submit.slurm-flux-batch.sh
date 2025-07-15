#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=4
#FLUX: --priority=16

date
echo "Slurm nodes: $SLURM_JOB_NODELIST"
NUM_GPUS=`echo $GPU_DEVICE_ORDINAL | tr ',' '\n' | wc -l`
echo "You were assigned $NUM_GPUS gpu(s)"
nvidia-smi
echo
source activate /home/ewang/miniconda3/envs/dit2
conda info 
echo "Training Start:"
torchrun --nnodes=1 --nproc_per_node=1 train.py --data-path datasets/THuman_random_64 --model "DiT-B/2"
echo
echo "Super Resolve Start:"
echo
echo "Ending script..."
date
