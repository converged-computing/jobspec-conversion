#!/bin/bash
#FLUX: --job-name=fugly-carrot-0512
#FLUX: -c=8
#FLUX: --priority=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/chroma_3.43.0-20211118.sif run-benchmark --ngpus 4
