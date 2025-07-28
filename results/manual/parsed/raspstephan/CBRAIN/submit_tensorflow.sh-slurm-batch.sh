#!/bin/bash
#FLUX: --job-name=tensorflow_gpu
#FLUX: -t=151140
#FLUX: --urgency=16

module load intel-parallel-studio/2017
module load cuda80/toolkit cuda80/blas cudnn/5.1 
module load anaconda/2-4.2.0 
mpiexec python ./main.py --batch_size=4096 --dataset='SPDQ' --hidden='5' # > atoutfile
date
