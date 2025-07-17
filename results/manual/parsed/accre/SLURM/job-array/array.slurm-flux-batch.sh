#!/bin/bash
#FLUX: --job-name=crunchy-kerfuffle-9894
#FLUX: -t=7200
#FLUX: --urgency=16

echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
module load Anaconda2
python vectorization_${SLURM_ARRAY_TASK_ID}.py
