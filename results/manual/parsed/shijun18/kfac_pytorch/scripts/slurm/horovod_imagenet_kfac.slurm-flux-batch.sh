#!/bin/bash
#FLUX: --job-name=boopy-citrus-0714
#FLUX: --urgency=16

scontrol show hostnames $SLURM_NODELIST > /tmp/hostfile
cat /tmp/hostfile
mpiexec -hostfile /tmp/hostfile -N 1 ./scripts/cp_imagenet_to_temp.sh
mpiexec -hostfile /tmp/hostfile -N 4 \
   python examples/horovod_imagenet_resnet.py \
     --kfac-update-freq 100 \
     --kfac-cov-update-freq 10 \
     --damping 0.001 \
     --epochs 55 \
     --lr-decay 25 35 40 45 50 \
     --model resnet50
