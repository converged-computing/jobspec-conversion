#!/bin/bash
#FLUX: --job-name=echo
#FLUX: -n=3
#FLUX: -t=60
#FLUX: --urgency=16

echo "slurm task ID = $SLURM_ARRAY_TASK_ID"
echo "today is $(date)" > output/echo_$SLURM_ARRAY_TASK_ID.out
