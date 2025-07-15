#!/bin/bash
#FLUX: --job-name=gan
#FLUX: --priority=16

module load gcc/latest
module load nvidia/7.5
module load cudnn/7.5-v5
python -m train.training_functions
