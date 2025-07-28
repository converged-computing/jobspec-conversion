#!/bin/bash
#FLUX: --job-name=myJobName
#FLUX: -t=46740
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR                            # go to the directory where this job is submitted
matlab -nodisplay -r "addpath(genpath('./.'));cd 3_deployment/outdoor_emulation;main_outdoor"
scontrol show job ${SLURM_JOBID}
