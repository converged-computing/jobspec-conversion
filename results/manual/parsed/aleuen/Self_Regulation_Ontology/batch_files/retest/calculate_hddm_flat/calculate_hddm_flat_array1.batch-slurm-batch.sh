#!/bin/bash
#FLUX: --job-name=hddm_flat
#FLUX: -c=4
#FLUX: --queue=russpold
#FLUX: -t=14400
#FLUX: --urgency=16

source /home/zenkavi/.bash_profile
source activate SRO
eval $( sed "${SLURM_ARRAY_TASK_ID}q;d" xaa )
