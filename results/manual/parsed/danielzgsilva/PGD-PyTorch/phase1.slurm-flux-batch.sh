#!/bin/bash
#FLUX: --job-name=goodbye-bike-0264
#FLUX: -t=172800
#FLUX: --urgency=16

date
echo "Slurm nodes: $SLURM_JOB_NODELIST"
NUM_GPUS=`echo $GPU_DEVICE_ORDINAL | tr ',' '\n' | wc -l`
echo "You were assigned $NUM_GPUS gpu(s)"
module load cuda/cuda-10.0
source activate pytorch-gpu
module list
nvidia-smi topo -m
echo
echo
time python validation.py
echo
echo "Ending script..."
date
