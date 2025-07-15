#!/bin/bash
#FLUX: --job-name=shapnet
#FLUX: -t=7200
#FLUX: --priority=16

python train_shapenet.py \
--dataset="shapenet" \
--data_dir="datasets/ShapeNet" \
--resume_epoch=-1 \
--test_epoch=-1 \
--lr=0.1 \
--optimizer="sgd" \
--spatial_size=64 \
--valid_spatial_size=64 \
--prune_spatial_size=64 \
--enable_cuda \
--width 2 \
--neuron_sparsity=0.782 \
--random_sparsity_seed=0 \
--resource_list_type="grad_flops" \
--test_target_class=-1 \
--enable_train \
