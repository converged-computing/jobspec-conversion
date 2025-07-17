#!/bin/bash
#FLUX: --job-name=multi-gpu-training
#FLUX: --queue=
#FLUX: --urgency=16

singularity exec --pwd $(pwd) --nv \
  -B /myovision:/mnt \
  image \
  bash -c "cd /mnt/myovision-sam && python3 inference.py"
