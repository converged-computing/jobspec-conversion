#!/bin/bash
#FLUX: --job-name=astute-diablo-5728
#FLUX: -c=4
#FLUX: -t=72000
#FLUX: --urgency=16

date
echo "Slurm nodes: $SLURM_JOB_NODELIST"
NUM_GPUS=`echo $GPU_DEVICE_ORDINAL | tr ',' '\n' | wc -l`
echo "You were assigned $NUM_GPUS gpu(s)"
module load anaconda/anaconda3
module listr
nvidia-smi topo -m
echo
source activate my-pytorch
echo
time python train_cifar.py \
--jobid $SLURM_JOB_ID \
--arch resnet56 \
--dataset cifar10 \
--compress-rate 0.63 \
--l2-weight 0.001 \
--add-bn True \
--epochs 120 \
--schedule 30 60 90 \
--lr 0.01
echo
echo "Ending script..."
date
