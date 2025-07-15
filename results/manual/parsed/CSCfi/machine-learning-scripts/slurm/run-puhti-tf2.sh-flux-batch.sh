#!/bin/bash
#FLUX: --job-name=ornery-car-8865
#FLUX: --urgency=16

module load tensorflow/2.0.0
module list
set -xv
srun python3.7 $*
