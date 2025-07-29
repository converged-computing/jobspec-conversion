#!/bin/bash
#FLUX: --job-name=tf2-multi
#FLUX: -c=16
#FLUX: -t=300
#FLUX: --urgency=16

module purge
module load anaconda3/2021.11
conda activate tf2-gpu
python mnist_classify.py
