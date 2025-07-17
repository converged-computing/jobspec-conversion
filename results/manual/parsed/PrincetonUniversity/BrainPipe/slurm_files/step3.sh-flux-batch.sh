#!/bin/bash
#FLUX: --job-name=astute-sundae-1164
#FLUX: -c=14
#FLUX: --queue=all
#FLUX: -t=42000
#FLUX: --urgency=16

module load anacondapy/2020.11
module load elastix/4.8
. activate brainpipe
xvfb-run python main.py 3 ${SLURM_ARRAY_TASK_ID} #run elastix; -d flag is NECESSARY for depth coding
