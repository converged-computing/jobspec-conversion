#!/bin/bash
#FLUX: --job-name=bootstrap_demog
#FLUX: -c=4
#FLUX: --queue=russpold,owners,normal
#FLUX: -t=14400
#FLUX: --urgency=16

source activate SRO
eval $( sed "${SLURM_ARRAY_TASK_ID}q;d" bootstrap_demog_tasklist )
