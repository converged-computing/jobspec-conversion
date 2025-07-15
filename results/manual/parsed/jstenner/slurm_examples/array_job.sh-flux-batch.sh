#!/bin/bash
#FLUX: --job-name=array_job_test
#FLUX: -t=300
#FLUX: --urgency=16

pwd; hostname; date
echo This is task $SLURM_ARRAY_TASK_ID
date
