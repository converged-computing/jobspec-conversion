#!/bin/bash
#FLUX: --job-name=ivan_debug
#FLUX: -c=10
#FLUX: -t=64800
#FLUX: --urgency=16

source /users/afengler/.bashrc
module load cudnn/8.1.0
module load cuda/11.1.1
module load gcc/10.2
conda deactivate
conda deactivate
conda activate lanfactory
python -u ivan_debug.py
