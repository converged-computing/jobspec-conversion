#!/bin/bash
#FLUX: --job-name=lovable-fork-3915
#FLUX: --priority=16

module load matlab/R2018b
srun matlab -nodisplay -nosplash -nodesktop -r "run('main.m'); exit;"
