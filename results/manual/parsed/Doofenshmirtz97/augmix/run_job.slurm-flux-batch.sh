#!/bin/bash
#FLUX: --job-name=convnext_tiny_npt_adam.o
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

env_dir=/home/g050878/.conda/envs/augmixenv
echo "$env_dir"  "Environment Directory"
source ~/.bashrc
conda activate $env_dir 
conda env list
bash set_up.sh
python cifar.py -m convnext_tiny -lrsc CosineAnnealingLR -optim AdamW -s ./convnext_tiny/adam_npt
