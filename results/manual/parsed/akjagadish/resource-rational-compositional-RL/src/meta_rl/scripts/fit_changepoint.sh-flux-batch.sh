#!/bin/bash
#FLUX: --job-name=RL3
#FLUX: -c=8
#FLUX: -t=360000
#FLUX: --urgency=16

cd ~/RL3NeurIPS/
module purge
conda activate pytorch-gpu
python3 fit.py --full --prior svdo --subject ${SLURM_ARRAY_TASK_ID} --changepoint
