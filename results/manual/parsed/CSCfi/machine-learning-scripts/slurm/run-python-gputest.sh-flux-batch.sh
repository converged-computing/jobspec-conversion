#!/bin/bash
#FLUX: --job-name=gloopy-train-3437
#FLUX: --urgency=16

module load python-env/3.6.3-ml
module list
set -xv
date
hostname
nvidia-smi
srun python3.6 $*
date
