#!/bin/bash
#FLUX: --job-name=train
#FLUX: -t=86400
#FLUX: --urgency=16

module load GCC/8.3.0
module load CUDA/10.2.89
cd ~/CSE803FinalProject
conda activate CVProj
WANDB_MODE=online python train.py --gpus=1 --model=SRResNet --batch_size=64
scontrol show job $SLURM_JOB_ID
