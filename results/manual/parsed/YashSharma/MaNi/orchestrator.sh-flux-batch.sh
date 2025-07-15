#!/bin/bash
#FLUX: --job-name=swampy-carrot-1711
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --priority=16

module load anaconda3
source activate pytorch_yash
python -u /scratch/ys5hd/EoE/CRC/finetune/orchestrator.py 0. 1. 'tcia' 'tnbc'
