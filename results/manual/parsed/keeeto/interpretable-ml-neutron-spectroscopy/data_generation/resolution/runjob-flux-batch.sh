#!/bin/bash
#FLUX: --job-name=stanky-bits-0778
#FLUX: --urgency=16

python2 generate_goodenough_resolution.py $SLURM_ARRAY_TASK_ID
