#!/bin/bash
#SBATCH --account=nim00007
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=96G
#SBATCH --time=06:00:00

source activate sam
python evaluate_amg.py -c /scratch/usr/nimanwai/micro-sam/checkpoints/vit_b/livecell_sam/best.pt \
                       -m vit_b \
                       -e /scratch/projects/nim00007/sam/experiments/new_models/specialists/lm/livecell/vit_b/
