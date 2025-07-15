#!/bin/bash
#FLUX: --job-name=MATLAB_ex
#FLUX: --queue=ssd
#FLUX: -t=300
#FLUX: --urgency=16

module load matlab
mkdir -p $SCRATCH/$USER/$SLURM_JOB_ID
matlab -nodisplay < MATLAB_example.m
rm -rf $SCRATCH/$USER/$SLURM_JOB_ID
