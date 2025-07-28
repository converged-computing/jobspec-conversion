#!/bin/bash
#FLUX: --job-name=emb
#FLUX: -N=2
#FLUX: -n=8
#FLUX: --queue=rtx
#FLUX: -t=1800
#FLUX: --urgency=16

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
