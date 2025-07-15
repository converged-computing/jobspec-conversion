#!/bin/bash
#FLUX: --job-name=goodbye-lemur-9310
#FLUX: --queue=maxwell
#FLUX: -t=600
#FLUX: --priority=16

module load Anaconda3
source activate pycuda
module load CUDA
module load GCC
module load Boost
python < pycuda_eg.py
