#!/bin/bash
#FLUX: --job-name='diffuseq-replica'
#FLUX: -c=4
#FLUX: -t=172799
#FLUX: --priority=16

export WANDB_API_KEY='$(cat wandb_login.txt)'

export WANDB_API_KEY=$(cat wandb_login.txt)
overlay=/scratch/ad6489/pytorch-example/overlay_img
img=/scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif
singularity exec --nv \
	--overlay $overlay:ro \
	$img \
       	/bin/bash -c \
	"source /ext3/env.sh; torchrun --nproc_per_node=4 --master_port=12233 /scratch/ad6489/thesis/DiffuSeq/scripts/run_train.py \
	--diff_steps 2000 \
	--lr 0.0001 \
	--learning_steps 30000 \
	--save_interval 10000 \
	--resume_checkpoint /scratch/ad6489/thesis/DiffuSeq/diffusion_models/diffuseq_qqp_h128_lr0.0001_t2000_sqrt_lossaware_seed102_test-qqp20231109-01:58:16/ema_0.9999_020000.pt \  
	--seed 102 \
	--noise_schedule sqrt \
	--hidden_dim 128 \
	--bsz 2048 \
	--dataset qqp \
	--data_dir /scratch/ad6489/thesis/DiffuSeq/datasets/QQP \
	--vocab bert \
	--seq_len 128 \
	--schedule_sampler lossaware \
	--notes test-qqp" \
	> log.out 2> log.err
