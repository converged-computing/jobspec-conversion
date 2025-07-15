#!/bin/bash
#FLUX: --job-name=butterscotch-salad-4833
#FLUX: --priority=16

module load tensorflow/2.4
module list
set -xv
srun python3 $*
