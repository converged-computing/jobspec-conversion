#!/bin/bash
#FLUX: --job-name=quirky-diablo-5445
#FLUX: -c=3
#FLUX: --queue=gpuhgx
#FLUX: -t=129600
#FLUX: --urgency=16

module load palma/2021b
module load Singularity
module load CUDA/11.6.0
singularity run --nv --bind .:/code open3d.sif train_essen.py "$1"
