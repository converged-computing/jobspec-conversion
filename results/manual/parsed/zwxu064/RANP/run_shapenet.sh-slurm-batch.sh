#!/bin/bash
#SBATCH --job-name=shapnet
#SBATCH --output=logs/test_shapenet.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=17GB
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=4

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
