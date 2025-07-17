#!/bin/bash
#FLUX: --job-name=confused-truffle-0402
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module list
set -xv
date
hostname
nvidia-smi
srun python3.5 $*
date
