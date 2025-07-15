#!/bin/bash
#FLUX: --job-name=grated-soup-2226
#FLUX: --urgency=16

ml R/4.0.0
heuristic='SA'
file='esc64a.txt'
workdir='/home/jarredondo/projects/QAP/'
Rscript --vanilla main.R $file 'SA' ${SLURM_ARRAY_TASK_ID} $workdir
