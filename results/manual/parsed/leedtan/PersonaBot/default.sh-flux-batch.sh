#!/bin/bash
#FLUX: --job-name=c_def
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load python-3.5 cuda-8.0
USE_CUDA=1 python3 -u model.py --modelname c_default --server 1
