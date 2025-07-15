#!/bin/bash
#FLUX: --job-name=stinky-lemur-6631
#FLUX: --urgency=16

module load anaconda3/2020.11
module load cuda/11.2.2
module load cudnn/11.2-8.1.1
conda activate prettyB
python /scratch/zyang43/ALP-Design/paper/e2e_grad.py
