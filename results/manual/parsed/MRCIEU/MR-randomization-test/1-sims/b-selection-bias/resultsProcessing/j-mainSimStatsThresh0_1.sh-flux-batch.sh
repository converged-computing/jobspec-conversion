#!/bin/bash
#FLUX: --job-name=j-mainSimStatsThresh0_1
#FLUX: --queue=veryshort
#FLUX: -t=21600
#FLUX: --priority=16

export RES_DIR='${HOME}/2021-randomization-test/results'

date
cd $SLURM_SUBMIT_DIR
module add languages/r/4.2.1
export RES_DIR="${HOME}/2021-randomization-test/results"
Rscript mainSimStatsThresh0_1.R
module add apps/matlab/2021a
matlab -r "resFileName='sim-resFIX-thresh0_1';plotRes"
date
