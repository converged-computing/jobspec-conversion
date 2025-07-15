#!/bin/bash
#FLUX: --job-name='llvm'
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --priority=16

export WANDB_API_KEY='$(cat wandb_login.txt)'

export WANDB_API_KEY=$(cat wandb_login.txt)
overlay=/scratch/ad6489/pytorch-example/overlay_img
img=/scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif
singularity exec --nv \
	--overlay $overlay:ro \
	$img \
       	/bin/bash -c \
	"source /ext3/env.sh; python main.py wandb_log=True" \
	> log.out 2> log.err
