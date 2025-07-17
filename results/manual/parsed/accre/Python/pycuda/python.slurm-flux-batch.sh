#!/bin/bash
#FLUX: --job-name=bricky-pastry-3814
#FLUX: --queue=maxwell
#FLUX: -t=600
#FLUX: --urgency=16

module load Anaconda3
source activate pycuda
module load CUDA
module load GCC
module load Boost
python < pycuda_eg.py
