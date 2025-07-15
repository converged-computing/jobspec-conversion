#!/bin/bash
#FLUX: --job-name=mnist
#FLUX: --queue=cascadelakegpu
#FLUX: -t=86400
#FLUX: --priority=16

export PATH='/home/ubu_eps_1/COMUNES/miniconda3/bin:$PATH'

export PATH=/home/ubu_eps_1/COMUNES/miniconda3/bin:$PATH
source /home/ubu_eps_1/COMUNES/miniconda3/etc/profile.d/conda.sh
conda activate env
python TFG_EMD_CV_DAonfly.py Xception True Parcial_all 16 K5 rgb
conda deactivate
