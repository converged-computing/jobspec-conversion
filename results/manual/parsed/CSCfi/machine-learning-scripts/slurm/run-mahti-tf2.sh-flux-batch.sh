#!/bin/bash
#FLUX: --job-name=grated-lizard-2423
#FLUX: --urgency=16

module load tensorflow/2.4
module list
set -xv
srun python3 $*
