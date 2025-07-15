#!/bin/bash
#FLUX: --job-name=delicious-eagle-7109
#FLUX: -t=86400
#FLUX: --urgency=16

singularity exec --nv \
  --overlay /scratch/wz1492/overlay-25GB-500K.ext3:ro \
  /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
  /bin/bash -c "source /scratch/wz1492/env.sh;"
python train.py
