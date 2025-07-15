#!/bin/bash
#FLUX: --job-name=faux-spoon-5647
#FLUX: --priority=16

lscpu
nvidia-smi
conda env update --file environment_gpu.yml --name ariadne_gpu
source ~/miniconda3/etc/profile.d/conda.sh
conda activate ariadne_gpu
"$@"
