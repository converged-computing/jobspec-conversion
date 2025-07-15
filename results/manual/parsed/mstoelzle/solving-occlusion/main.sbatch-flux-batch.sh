#!/bin/bash
#FLUX: --job-name=frigid-bits-6286
#FLUX: --queue=cor,general
#FLUX: -t=604800
#FLUX: --priority=16

module use /opt/insy/modulefiles
module load cuda/11.2
module load miniconda
module load devtoolset/10 # newest version of gcc / g++
conda activate rsl-solving-occlusion
which python
nvidia-smi
python -u main.py $1
conda deactivate
