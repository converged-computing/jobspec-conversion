#!/bin/bash
#FLUX: --job-name=lovely-house-2695
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load pytorch/1.2.0
module list
set -xv
srun python3.7 $*
