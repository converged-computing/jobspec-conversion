#!/bin/bash
#FLUX: --job-name=peachy-train-0190
#FLUX: --queue=
#FLUX: --urgency=16

singularity exec --pwd $(pwd) --nv \
  -B /myovision:/mnt \
  image \
  bash -c "cd /mnt/myovision-sam && python3 inference.py"
