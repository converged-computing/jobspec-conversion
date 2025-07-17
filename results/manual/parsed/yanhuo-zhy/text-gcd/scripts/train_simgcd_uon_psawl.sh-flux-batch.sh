#!/bin/bash
#FLUX: --job-name=astute-underoos-9532
#FLUX: -c=5
#FLUX: --queue=amp48
#FLUX: --urgency=16

module load gcc/gcc-10.2.0
module load nvidia/cuda-11.1 nvidia/cudnn-v8.1.1.33-forcuda11.0-to-11.2
source /home/psawl/miniconda3/bin/activate zhy
CUDA_VISIBLE_DEVICES=0 python SimGCD/train.py \
 --dataset_name='cifar100' \
 --seed_num=2 \
 --prop_train_labels=0.5 \
 --prop_knownclass=0.5 \
 --exp_name='SimGCD_cifar100_prob_knownclass(0.5)_seed2' \
 --print_freq=20
