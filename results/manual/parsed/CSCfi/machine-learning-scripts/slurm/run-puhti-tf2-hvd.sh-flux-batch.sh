#!/bin/bash
#FLUX: --job-name=spicy-kitty-7541
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load tensorflow
module list
set -xv
srun python3 $*
