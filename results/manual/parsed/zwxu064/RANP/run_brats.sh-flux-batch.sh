#!/bin/bash
#FLUX: --job-name=brats
#FLUX: -t=7200
#FLUX: --priority=16

python train_brats.py \
--dataset="brats" \
--data_dir="datasets/BraTS"  \
--resume_epoch=-1 \
--test_epoch=-1 \
--optimizer="adam" \
--spatial_size=128 \
--prune_spatial_size=96 \
--enable_cuda \
--width 2 \
--number_of_fmaps 4 \
--neuron_sparsity=0.7817 \
--resource_list_type="grad_flops" \
--enable_train \
--valid_spatial_size=192 \
