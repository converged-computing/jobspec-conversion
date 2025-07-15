#!/bin/bash
#FLUX: --job-name=conspicuous-bits-8246
#FLUX: --priority=16

module load tensorflow
module list
set -xv
srun python3 $*
