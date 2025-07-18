#!/bin/bash
#FLUX: --job-name=getgraphs
#FLUX: -n=2
#FLUX: -t=86400
#FLUX: --urgency=16

source activate.sh
if [ ! -z "$SLURM_ARRAY_TASK_ID"]
then
    jan="--job_array_number $SLURM_ARRAY_TASK_ID"
else
    jan=""
fi
python -u sastvd/scripts/getgraphs.py bigvul --sess $jan --num_jobs 100 --overwrite $@
