#!/bin/bash
#FLUX: --job-name=tart-rabbit-0593
#FLUX: -c=8
#FLUX: --priority=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/rochpcg3.1.0_97.sif mpirun -np 3 hpcg 280 280 280 1860
