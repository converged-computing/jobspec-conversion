#!/bin/bash
#FLUX: --job-name=expensive-car-3858
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load CUDA
module load MATLAB/2019a
srun matlab -nodisplay -nosplash < train_dqn.m
