#!/bin/bash
#FLUX: --job-name=muffled-chair-9281
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/rochpl_5.0.5_49.sif mpirun_rochpl -P 2 -Q 2 -N 181248 --NB 512 
