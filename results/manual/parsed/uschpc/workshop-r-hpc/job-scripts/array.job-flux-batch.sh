#!/bin/bash
#FLUX: --job-name=stinky-butter-6967
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load gcc/11.3.0
module load openblas/0.3.20
module load r/4.3.1
printf "%s\n" "Task ID: $SLURM_ARRAY_TASK_ID"
Rscript array.R
