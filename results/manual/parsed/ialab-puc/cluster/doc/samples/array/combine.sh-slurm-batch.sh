#!/bin/bash
#FLUX: --job-name=combine_random
#FLUX: -t=300
#FLUX: --urgency=16

pwd; hostname; date
python3 /user/slurm/samples/array/combine.py $SLURM_ARRAY_TASK_ID
date
