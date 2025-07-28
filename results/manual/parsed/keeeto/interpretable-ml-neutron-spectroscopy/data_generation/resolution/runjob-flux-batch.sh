#!/bin/bash
#FLUX: --job-name=persnickety-poodle-3023
#FLUX: --queue=scarf
#FLUX: -t=108000
#FLUX: --urgency=16

python2 generate_goodenough_resolution.py $SLURM_ARRAY_TASK_ID
