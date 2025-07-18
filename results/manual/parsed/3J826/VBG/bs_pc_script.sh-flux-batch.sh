#!/bin/bash
#FLUX: --job-name=s5
#FLUX: -t=29400
#FLUX: --urgency=16

WANDB_API_KEY=$17a113b4804951bde9c66b2002fe378c0209fb64
WANDB_ENTITY=$mizunt
module load python/3.9
module load cuda/11.2/cudnn/8.1
module load singularity/3.7.1
singularity exec --nv sl_img.simg python3 main.py bs --method pc
