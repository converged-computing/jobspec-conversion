#!/bin/bash
#FLUX: --job-name=seqtrain
#FLUX: -N=2
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

export WANDB__SERVICE_WAIT='300'

source ~/miniconda3/etc/profile.d/conda.sh
conda activate pytorch_env
export WANDB__SERVICE_WAIT=300
srun python train_convnext_SequecingWithzaporednimifrmi2nodes.py 
