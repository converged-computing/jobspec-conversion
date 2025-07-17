#!/bin/bash
#FLUX: --job-name=wavetank
#FLUX: -n=192
#FLUX: --queue=development
#FLUX: -t=3600
#FLUX: --urgency=16

set -x
source /home1/01082/smattis/src/proteus/envConfig
mkdir $SLURM_JOB_NAME.$SLURM_JOB_ID
ibrun parun tank_so.py  -l 3 -v -D $SLURM_JOB_NAME.$SLURM_JOB_ID -O ../../petsc.options.asm -o context.options #-p
