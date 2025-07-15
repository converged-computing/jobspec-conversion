#!/bin/bash
#FLUX: --job-name=grated-soup-5489
#FLUX: --queue=# set partition name
#FLUX: --priority=16

singularity exec --pwd $(pwd) --nv \
  -B /myovision:/mnt \
  image \
  bash -c "cd /mnt/myovision-sam && python3 inference.py"
