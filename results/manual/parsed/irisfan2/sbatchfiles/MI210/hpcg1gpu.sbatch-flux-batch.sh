#!/bin/bash
#FLUX: --job-name=frigid-pedo-4626
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/hpcg1-$$
mkdir -p $tmp
singularity run /shared/apps/bin/rochpcg_3.1.amd1_21.sif mpirun --mca pml ucx -np 1 rochpcg 336 168 672 1860
rm -rf /tmp/$USER/hpcg1-$$
