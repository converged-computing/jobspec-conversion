#!/bin/bash
#FLUX: --job-name=goodbye-nalgas-9322
#FLUX: --urgency=16

module load tensorflow
module list
set -xv
srun python3 $*
