#!/bin/bash
#FLUX: --job-name=Latte-ffs
#FLUX: -c=16
#FLUX: --queue=group-name
#FLUX: -t=1800000
#FLUX: --priority=16

source ~/.bashrc
conda activate latte
srun python train.py --config ./configs/sky/sky_train.yaml
