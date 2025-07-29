#!/bin/bash
#SBATCH --job-name=brats
#SBATCH --output=logs/test_brats.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=17GB
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=4

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
