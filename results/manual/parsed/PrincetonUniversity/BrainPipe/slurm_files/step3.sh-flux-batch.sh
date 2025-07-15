#!/bin/bash
#FLUX: --job-name=delicious-taco-9274
#FLUX: --urgency=16

module load anacondapy/2020.11
module load elastix/4.8
. activate brainpipe
xvfb-run python main.py 3 ${SLURM_ARRAY_TASK_ID} #run elastix; -d flag is NECESSARY for depth coding
