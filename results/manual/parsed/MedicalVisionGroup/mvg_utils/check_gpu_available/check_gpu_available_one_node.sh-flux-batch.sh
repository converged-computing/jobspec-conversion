#!/bin/bash
#FLUX: --job-name=chk_gpu
#FLUX: --urgency=16

set -e # fail fully on first line failure
echo "$(hostname)"
if [ -z "$SLURM_ARRAY_TASK_ID" ]
then
    # Not in Slurm Job Array - running in single mode
    JOB_ID=$SLURM_JOB_ID
else
    # In array
    JOB_ID="${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
fi
srun nvidia-smi
rm "slurm-${JOB_ID}.out"
