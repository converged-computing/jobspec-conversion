#!/bin/bash
#FLUX: --job-name=arraytest
#FLUX: --queue=normal_q
#FLUX: --urgency=16

echo SLURM_JOB_ID $SLURM_JOB_ID
echo SLURM_ARRAY_JOB_ID $SLURM_ARRAY_JOB_ID
echo SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID
