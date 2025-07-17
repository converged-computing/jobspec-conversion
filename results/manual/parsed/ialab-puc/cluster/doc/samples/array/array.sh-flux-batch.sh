#!/bin/bash
#FLUX: --job-name=average_random
#FLUX: -t=300
#FLUX: --urgency=16

python3 /user/slurm/samples/array/average.py $SLURM_ARRAY_TASK_ID
