#!/bin/bash
#FLUX: --job-name=frigid-lamp-6530
#FLUX: --priority=16

module load tensorflow/2.0.0
module list
set -xv
srun python3.7 $*
