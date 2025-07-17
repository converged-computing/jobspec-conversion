#!/bin/bash
#FLUX: --job-name=fat-lemur-0678
#FLUX: -t=30
#FLUX: --urgency=16

LAST_PIECE=16
if [[ "${SLURM_ARRAY_TASK_ID}" -eq "1" ]]; then
        # If this is ARRAY_TASK_ID 1, sander1, we pass our Arguments here so we can run leap corectly
        runamber $SLURM_ARRAY_TASK_ID $@
elif [[ "${SLURM_ARRAY_TASK_ID}" -eq "${LAST_PIECE}" ]]; then
        runamber $SLURM_ARRAY_TASK_ID -L
else
        # If it is not ARRAY_TASK_ID 1, just run the next job in the line
        runamber $SLURM_ARRAY_TASK_ID
fi
