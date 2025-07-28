#!/bin/bash
#FLUX: --job-name=quirky-squidward-1834
#FLUX: --queue=maxwell
#FLUX: -t=600
#FLUX: --urgency=16

module load MATLAB   # Load the default version of Matlab from LMod
matlab -nodisplay -nosplash -nojvm < gpu_eg.m
