#!/bin/bash
#FLUX: --job-name=baseline_landscape_job
#FLUX: -n=2
#FLUX: -t=259200
#FLUX: --urgency=16

source ~/.bashrc
module load cuda/11.8
cd ~/MaskGIT-PAT
python training_vqgan.py \
    --dataset-path /groups/mlprojects/pat/landscape/ \
    --batch-size 4 \
    --experiment-name baseline_landscape_3days \
    --save-img-rate 1000 \
    --epochs 1000
