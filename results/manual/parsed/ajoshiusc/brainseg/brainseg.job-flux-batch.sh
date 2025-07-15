#!/bin/bash
#FLUX: --job-name=scruptious-hippo-2107
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --priority=16

module purge
module load nvidia-hpc-sdk
module load gcc/8.3.0
python /scratch1/wenhuicu/brainseg/train_robust.py --loss='BCE' --beta=0.0001 --warmup=2 --class_weight=1 --suffix='_weighted_BCE'
