#!/bin/bash
#FLUX: --job-name=rainbow-banana-4204
#FLUX: --priority=16

echo "slurm task ID = $SLURM_ARRAY_TASK_ID"
echo "today is $(date)" > output/echo_$SLURM_ARRAY_TASK_ID.out
