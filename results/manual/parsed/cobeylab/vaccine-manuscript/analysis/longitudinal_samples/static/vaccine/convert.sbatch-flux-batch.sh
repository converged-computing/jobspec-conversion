#!/bin/bash
#FLUX: --job-name=persnickety-malarkey-6529
#FLUX: --queue=amd
#FLUX: -t=1800
#FLUX: --urgency=16

rm results/$SLURM_ARRAY_TASK_ID/long.csv
if [ -f results/$SLURM_ARRAY_TASK_ID/out.long ]; then
    Rscript convert.R $SLURM_ARRAY_TASK_ID
fi
