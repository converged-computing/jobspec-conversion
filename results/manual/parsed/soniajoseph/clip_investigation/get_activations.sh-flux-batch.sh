#!/bin/bash
#FLUX: --job-name=get_activations
#FLUX: --queue=long
#FLUX: -t=3600
#FLUX: --urgency=16

module load anaconda/3
module load cuda/11.7
module load libffi
source /home/mila/s/sonia.joseph/ViT-Planetarium/env/bin/activate
python get_activations.py --layer_num $SLURM_ARRAY_TASK_ID --attn
