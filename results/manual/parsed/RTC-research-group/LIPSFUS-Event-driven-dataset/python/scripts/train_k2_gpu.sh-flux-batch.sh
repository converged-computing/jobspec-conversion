#!/bin/bash
#FLUX: --job-name=NN_trainner
#FLUX: -t=36000
#FLUX: --priority=16

module add libs/nvidia-cuda/11.0.3/bin
module add apps/anaconda3/5.2.0/bin
source ~/.bashrc
conda activate /mnt/scratch2/users/arios/conda/envs/sensory-fusion
nvidia-smi
python visual_NN_classifier.py
