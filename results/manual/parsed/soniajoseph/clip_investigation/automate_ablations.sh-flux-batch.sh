#!/bin/bash
#FLUX: --job-name=automate_ablations
#FLUX: --queue=long
#FLUX: -t=3000
#FLUX: --urgency=16

module load anaconda/3
module load cuda/11.7
module load libffi
source /home/mila/s/sonia.joseph/ViT-Planetarium/env/bin/activate
python automate_ablations.py --layer_num $SLURM_ARRAY_TASK_ID --layer_type "fc2"
