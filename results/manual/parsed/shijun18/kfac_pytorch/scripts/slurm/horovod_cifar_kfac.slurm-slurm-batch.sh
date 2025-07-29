#!/bin/bash
#FLUX: --job-name=cifkfc4
#FLUX: -n=4
#FLUX: --queue=v100
#FLUX: -t=14400
#FLUX: --urgency=16

mkdir -p sbatch_logs
source $SCRATCH/anaconda3/bin/activate pytorch
scontrol show hostnames $SLURM_NODELIST > /tmp/hostfile
cat /tmp/hostfile
mpiexec -hostfile /tmp/hostfile -N 4 \
   python examples/horovod_cifar10_resnet.py \
     --base-lr 0.1 \
     --epochs 100 \
     --kfac-update-freq 10 \
     --model resnet32 \
     --lr-decay 35 75 90
