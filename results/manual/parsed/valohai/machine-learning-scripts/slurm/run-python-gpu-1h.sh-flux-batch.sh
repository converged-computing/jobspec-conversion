#!/bin/bash
#FLUX: --job-name=psycho-poodle-0331
#FLUX: --priority=16

module list
set -xv
date
hostname
nvidia-smi
srun python3.5 $*
date
