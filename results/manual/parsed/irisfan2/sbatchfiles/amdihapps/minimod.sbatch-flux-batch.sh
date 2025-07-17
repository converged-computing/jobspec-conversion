#!/bin/bash
#FLUX: --job-name=expressive-toaster-8973
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/minimod.sif benchmark-acousticISO
