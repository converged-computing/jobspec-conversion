#!/bin/bash
#FLUX: --job-name=matlab-example
#FLUX: --queue=eng-research
#FLUX: -t=14400
#FLUX: --urgency=16

cd /scratch/users/netID/matlab-file-directory/
unset DISPLAY
module load matlab/9.7
matlab -nodisplay -r main.m >& logs/${SLURM_JOB_NAME}_${SLURM_JOB_ID}.oe
