#!/bin/bash
#FLUX: --job-name=fat-cinnamonbun-2722
#FLUX: --urgency=16

module list
set -xv
date
hostname
nvidia-smi
srun python3.5 $*
date
