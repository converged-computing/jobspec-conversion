#!/bin/bash
#FLUX: --job-name=moolicious-leg-5312
#FLUX: --urgency=16

module load matlab/R2018b
srun matlab -nodisplay -nosplash -nodesktop -r "run('main.m'); exit;"
