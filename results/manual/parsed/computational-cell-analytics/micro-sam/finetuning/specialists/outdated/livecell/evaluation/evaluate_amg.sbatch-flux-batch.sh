#!/bin/bash
#FLUX: --job-name=creamy-pancake-6648
#FLUX: -c=8
#FLUX: --queue=grete:shared
#FLUX: -t=21600
#FLUX: --urgency=16

source activate sam
python evaluate_amg.py -c /scratch/usr/nimanwai/micro-sam/checkpoints/vit_b/livecell_sam/best.pt \
                       -m vit_b \
                       -e /scratch/projects/nim00007/sam/experiments/new_models/specialists/lm/livecell/vit_b/
