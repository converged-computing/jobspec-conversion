#!/bin/bash
#FLUX: --job-name=crusty-bicycle-8040
#FLUX: --urgency=16

module load pytorch/1.2.0
module list
set -xv
srun python3.7 $*
