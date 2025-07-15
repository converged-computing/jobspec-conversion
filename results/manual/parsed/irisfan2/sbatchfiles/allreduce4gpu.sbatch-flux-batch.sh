#!/bin/bash
#FLUX: --job-name=salted-signal-4390
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.3.0
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/rocmtests_5.3.0-ub20.sif /home/rccl-tests/build/all_reduce_perf -b 8 -e 16G -f 2 -g 4 -c 0
rm -rf $tmp
