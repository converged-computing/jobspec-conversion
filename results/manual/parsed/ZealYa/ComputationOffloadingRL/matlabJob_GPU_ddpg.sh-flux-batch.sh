#!/bin/bash
#FLUX --job-name=chunky-gato-9993
#FLUX -c=4
#FLUX -t=172800
#FLUX --urgency=16

module purge
module load CUDA
module load MATLAB/2019a
srun matlab -nodisplay -nosplash < train_ddpg.m
