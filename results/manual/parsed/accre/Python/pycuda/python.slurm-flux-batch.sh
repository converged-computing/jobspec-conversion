#!/bin/bash
#FLUX: --job-name=lovable-car-6318
#FLUX: --queue=maxwell
#FLUX: -t=600
#FLUX: --urgency=16

module load Anaconda3
source activate pycuda
module load CUDA
module load GCC
module load Boost
python < pycuda_eg.py
