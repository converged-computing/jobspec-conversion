#!/bin/bash
#FLUX: --job-name=evasive-toaster-4293
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/hpcg8-$$
mkdir -p $tmp
singularity run /shared/apps/bin/rochpcg_3.1.amd1_21.sif mpirun --mca pml ucx -np 8 rochpcg 336 168 672 1860
rm -rf /tmp/$USER/hpcg8-$$
