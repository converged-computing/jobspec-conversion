#!/bin/bash
#FLUX: --job-name=angry-fork-9888
#FLUX: --priority=16

module load cuda/10.1
source $HOME/programs/anaconda3/bin/activate
conda activate SUMMA
srun python pretrain_develop.py \
    --checkpoint-activations \
    --distribute-checkpointed-activations \
    --master-port 2048 \
    --batch-size 96 \
    --hidden-size 2048 \
    --rank-rearrange
