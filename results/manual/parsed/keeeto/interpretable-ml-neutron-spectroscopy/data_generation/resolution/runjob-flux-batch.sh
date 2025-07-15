#!/bin/bash
#FLUX: --job-name=frigid-nunchucks-4685
#FLUX: --priority=16

python2 generate_goodenough_resolution.py $SLURM_ARRAY_TASK_ID
