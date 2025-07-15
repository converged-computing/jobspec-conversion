#!/bin/bash
#FLUX: --job-name=crunchy-lamp-2358
#FLUX: -t=64800
#FLUX: --priority=16

source /users/afengler/.bashrc
module load cudnn/8.1.0
module load cuda/11.1.1
module load gcc/10.2
conda deactivate
conda deactivate
conda activate lanfactory
python -u ivan_debug.py
