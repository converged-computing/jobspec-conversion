#!/bin/bash
#FLUX: --job-name=ucf101_mb
#FLUX: -t=7200
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES="2,3" \
python train_ucf101.py \
--dataset="ucf101" \
--video_path "./datasets/UCF101/images" \
--annotation_path "./datasets/annotations/annotation_UCF101/ucf101_01.json" \
--checkpoint_dir "results/ucf101/0194_grad_flops_80" \
--model "i3d" \
--groups 3 \
--width_mult 1.0 \
--downsample 1 \
--n_threads 32 \
--checkpoint 1 \
--n_val_samples 3 \
--resource_list_type "grad_flops" \
--neuron_sparsity 0.0194 \
--enable_train \
--pretrain_path="/home/users/u5710355/WorkSpace/gitlab/pytorch-projects/RANP/models/ucf101_i3d/rgb_imagenet.pt" \
--ft_portion="complete" \
--resource_list_lambda 80 \
--batch 32
