#!/bin/bash
#FLUX: --job-name=train_ResNet_sseg_and_depth
#FLUX: -c=15
#FLUX: --queue=gpuq
#FLUX: -t=432000
#FLUX: --urgency=16

module load cuda/11.2
module load python/3.7.4
module load gcc/7.5.0
source /scratch/yli44/habitat_env_argo/bin/activate
python train_ResNet_input_view.py
