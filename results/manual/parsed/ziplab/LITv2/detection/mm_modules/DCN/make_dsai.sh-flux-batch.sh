#!/bin/bash
#FLUX: --job-name=swampy-carrot-5961
#FLUX: -c=20
#FLUX: -t=172800
#FLUX: --urgency=16

module load cuda-11.2.0-gcc-10.2.0-gsjevs3
source activate torch171
nvidia-smi
nvcc -V
python setup.py build install
