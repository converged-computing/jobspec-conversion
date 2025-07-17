#!/bin/bash
#FLUX: --job-name=sweep-job
#FLUX: -c=16
#FLUX: --queue=palamut-cuda
#FLUX: -t=14460
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=0 singularity run --nv deep-learning_latest.sif wandb agent ayberkydn/vis/zolkri6c &
CUDA_VISIBLE_DEVICES=0 singularity run --nv deep-learning_latest.sif wandb agent ayberkydn/vis/zolkri6c &
CUDA_VISIBLE_DEVICES=1 singularity run --nv deep-learning_latest.sif wandb agent ayberkydn/vis/zolkri6c &
CUDA_VISIBLE_DEVICES=1 singularity run --nv deep-learning_latest.sif wandb agent ayberkydn/vis/zolkri6c &
