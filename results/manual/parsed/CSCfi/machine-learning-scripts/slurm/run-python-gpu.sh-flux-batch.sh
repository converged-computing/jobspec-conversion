#!/bin/bash
#FLUX: --job-name=chunky-poodle-1069
#FLUX: --priority=16

module load python-env/3.6.3-ml
module list
set -xv
date
hostname
nvidia-smi
srun python3.6 $*
date
