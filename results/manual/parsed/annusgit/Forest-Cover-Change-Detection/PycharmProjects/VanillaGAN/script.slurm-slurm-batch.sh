#!/bin/bash
#FLUX: --job-name=gan
#FLUX: -t=18000
#FLUX: --urgency=16

module load gcc/latest
module load nvidia/7.5
module load cudnn/7.5-v5
python -m train.training_functions
