#!/bin/bash
#FLUX: --job-name=no_augment
#FLUX: -c=4
#FLUX: -t=32400
#FLUX: --priority=16

module load anaconda
module load cuda 
source activate w2v2
srun python -u /scratch/work/lunt1/wav2vec2-finetune/run_finetune.py \
--lang=fi \
--fold=$SLURM_ARRAY_TASK_ID \
