#!/bin/bash
#FLUX: --job-name=quirky-cattywampus-8045
#FLUX: --priority=16

source activate sam
python evaluate_amg.py -c /scratch/usr/nimanwai/micro-sam/checkpoints/vit_b/livecell_sam/best.pt \
                       -m vit_b \
                       -e /scratch/projects/nim00007/sam/experiments/new_models/specialists/lm/livecell/vit_b/
