#!/bin/bash
#FLUX: --job-name=cowy-chair-9795
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

module load python-env/3.6.3-ml
module list
set -xv
date
hostname
nvidia-smi
srun python3.6 $*
date
