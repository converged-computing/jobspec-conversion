#!/bin/bash
#FLUX: --job-name=grated-fudge-0030
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/minimod.sif benchmark-acousticISO
