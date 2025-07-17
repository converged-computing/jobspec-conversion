#!/bin/bash
#FLUX: --job-name=diffuseq-replica-decode
#FLUX: -c=4
#FLUX: -t=82800
#FLUX: --urgency=16

export WANDB_API_KEY='$(cat wandb_login.txt)'

export WANDB_API_KEY=$(cat wandb_login.txt)
overlay=/scratch/ad6489/pytorch-example/overlay_img
img=/scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif
singularity exec --nv \
	--overlay $overlay:ro \
	$img \
       	/bin/bash -c \
	"source /ext3/env.sh; python -u /scratch/ad6489/thesis/DiffuSeq/scripts/run_decode.py \
	--model_dir diffusion_models/diffuseq_qqp_h128_lr0.0001_t2000_sqrt_lossaware_seed102_test-qqp20231109-01\:58\:16 \
	--seed 110 \
	--split test"
