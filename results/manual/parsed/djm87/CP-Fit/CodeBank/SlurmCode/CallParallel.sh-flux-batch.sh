#!/bin/bash
#FLUX: --job-name=WE43_Maud_Refinements
#FLUX: --queue=thrust2
#FLUX: -t=3600
#FLUX: --urgency=16

declare -a runStart=(1)
declare -a runEnd=(7)
seq ${runStart[${SLURM_ARRAY_TASK_ID}]} ${runEnd[${SLURM_ARRAY_TASK_ID}]} | xargs -n 1 -P 7 bash Maud_batch.sh
