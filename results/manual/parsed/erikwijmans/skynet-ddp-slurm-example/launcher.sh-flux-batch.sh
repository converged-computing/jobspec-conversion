#!/bin/bash
#FLUX: --job-name=cifar10-ddp
#FLUX: --gpus-per-task=1
#FLUX: --queue=short
#FLUX: --urgency=16

export MASTER_ADDR='$(srun --ntasks=1 hostname 2>&1 | tail -n1)'

export MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
set -x
srun -u python -u -m ddp_example.train_cifar10
