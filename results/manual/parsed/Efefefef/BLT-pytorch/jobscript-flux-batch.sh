#!/bin/bash
#FLUX: --job-name=carnivorous-snack-3386
#FLUX: --urgency=16

echo "running in shell: " "$SHELL"
spack load cuda@11.8.0
spack load cudnn@8.6.0.163-11.8
spack load miniconda3
eval "$(conda shell.bash hook)"
conda activate h100
python train.py
