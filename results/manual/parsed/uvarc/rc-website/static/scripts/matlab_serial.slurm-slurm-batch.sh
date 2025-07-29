#!/bin/bash
#FLUX: --job-name=runSingleTest
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --urgency=16

module load matlab
nLoops=400; # number of iterations to perform
nDim=400; # Dimension of matrix to create
matlab -nodisplay -r "pcalc2(${nLoops},${nDim},'${SLURM_JOB_ID}'); exit;"
