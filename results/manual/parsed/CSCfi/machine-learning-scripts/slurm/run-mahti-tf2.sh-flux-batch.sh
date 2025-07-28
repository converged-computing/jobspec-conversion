#!/bin/bash
#FLUX: --job-name=arid-platanos-7556
#FLUX: -c=10
#FLUX: --queue=gpusmall
#FLUX: -t=3600
#FLUX: --urgency=16

module load tensorflow/2.4
module list
set -xv
srun python3 $*
