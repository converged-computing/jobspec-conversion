#!/bin/bash
#FLUX: --job-name=fat-fork-9639
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load tensorflow/2.0.0
module list
set -xv
srun python3.7 $*
