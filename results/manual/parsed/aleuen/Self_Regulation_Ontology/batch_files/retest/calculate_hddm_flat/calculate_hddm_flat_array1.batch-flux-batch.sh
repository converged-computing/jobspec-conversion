#!/bin/bash
#FLUX: --job-name=outstanding-soup-4084
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --priority=16

source /home/zenkavi/.bash_profile
source activate SRO
eval $( sed "${SLURM_ARRAY_TASK_ID}q;d" xaa )
