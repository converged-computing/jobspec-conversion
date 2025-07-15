#!/bin/bash
#FLUX: --job-name=psycho-gato-3604
#FLUX: --queue=maxwell
#FLUX: -t=600
#FLUX: --urgency=16

module load MATLAB   # Load the default version of Matlab from LMod
matlab -nodisplay -nosplash -nojvm < gpu_eg.m
