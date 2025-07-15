#!/bin/bash
#FLUX: --job-name=faux-general-6936
#FLUX: --priority=16

module load pytorch/1.2.0
module list
set -xv
srun python3.7 $*
