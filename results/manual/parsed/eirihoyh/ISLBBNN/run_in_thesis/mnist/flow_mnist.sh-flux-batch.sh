#!/bin/bash
#FLUX: --job-name=f_mnist
#FLUX: -n=12
#FLUX: --queue=gpu
#FLUX: --urgency=16

module purge                # Clean all modules
module load Miniconda3
eval "$(conda shell.bash hook)"
conda activate skip_con
python flow_mnist.py
