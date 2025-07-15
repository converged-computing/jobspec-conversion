#!/bin/bash
#FLUX: --job-name=buttery-snack-0550
#FLUX: --queue=batch
#FLUX: -t=180000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load matlab/R2018a
matlab -nodisplay < iterationsAndOptimization.m
