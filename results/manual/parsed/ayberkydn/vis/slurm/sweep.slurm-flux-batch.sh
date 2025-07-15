#!/bin/bash
#FLUX: --job-name=nerdy-pastry-7139
#FLUX: -c=16
#FLUX: -t=72000
#FLUX: --urgency=16

SWEEP_ID=ayberkydn/vis/gd03qcz6
CUDA_VISIBLE_DEVICES=0 singularity run --nv vis_latest.sif wandb agent $SWEEP_ID &
CUDA_VISIBLE_DEVICES=0 singularity run --nv vis_latest.sif wandb agent $SWEEP_ID &
CUDA_VISIBLE_DEVICES=1 singularity run --nv vis_latest.sif wandb agent $SWEEP_ID &
CUDA_VISIBLE_DEVICES=1 singularity run --nv vis_latest.sif wandb agent $SWEEP_ID &
wait
