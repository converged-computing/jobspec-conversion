#!/bin/bash
#FLUX: --job-name=invertRandArray
#FLUX: -t=600
#FLUX: --priority=16

module load matlab/r2020a
mkdir -p /tmp/$SLURM_JOB_ID
matlab -nodisplay -r "invertRand('10^4'), quit"
