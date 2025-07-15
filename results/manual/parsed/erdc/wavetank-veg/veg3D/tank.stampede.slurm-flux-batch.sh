#!/bin/bash
#FLUX: --job-name=blank-bicycle-8393
#FLUX: --priority=16

set -x
source /home1/01082/smattis/src/proteus/envConfig
mkdir $SLURM_JOB_NAME.$SLURM_JOB_ID
ibrun parun tank_so.py  -l 3 -v -D $SLURM_JOB_NAME.$SLURM_JOB_ID -O ../../petsc.options.asm -o context.options #-p
