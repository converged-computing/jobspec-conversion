#!/bin/bash
#FLUX: --job-name=carnivorous-itch-2778
#FLUX: -c=10
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/rochpl_5.0.5_49.sif mpirun_rochpl -P 1 -Q 1 -N 91136 --NB 512 
