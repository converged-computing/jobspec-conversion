#!/bin/bash
#FLUX: --job-name=testjob
#FLUX: --queue=plgrid-gpu
#FLUX: -t=600
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
myCalculations $SLURM_ARRAY_TASK_ID
