#!/bin/bash
#FLUX: --job-name=spicy-hippo-9283
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load nvidia-hpc-sdk
module load gcc/8.3.0
python /scratch1/wenhuicu/brainseg/train_robust.py --loss='BCE' --beta=0.0001 --warmup=2 --class_weight=1 --suffix='_weighted_BCE'
