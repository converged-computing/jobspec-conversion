#!/bin/bash
#FLUX: --job-name=grated-dog-9035
#FLUX: --urgency=16

lscpu
nvidia-smi
conda env update --file environment_gpu.yml --name ariadne_gpu
source ~/miniconda3/etc/profile.d/conda.sh
conda activate ariadne_gpu
"$@"
