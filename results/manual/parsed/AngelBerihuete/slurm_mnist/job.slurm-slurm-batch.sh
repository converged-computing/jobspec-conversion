#!/bin/bash
#FLUX: --job-name=tf2-test
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load anaconda3
conda activate tf2-gpu
srun python mnist2_classify.py
