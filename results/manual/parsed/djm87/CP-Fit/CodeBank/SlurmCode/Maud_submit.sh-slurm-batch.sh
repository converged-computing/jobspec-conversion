#!/bin/bash
#FLUX: --job-name=WE43_Maud_refinements
#FLUX: --queue=thrust2
#FLUX: -t=1800
#FLUX: --urgency=16

find . -name \*CPU* -type f -delete
declare -a runStart=(1 33 65 97)
declare -a runEnd=(32 64 96 106)
seq ${runStart[${SLURM_ARRAY_TASK_ID}]} ${runEnd[${SLURM_ARRAY_TASK_ID}]} | xargs -n 1 -P 32 bash Maud_batch.sh
