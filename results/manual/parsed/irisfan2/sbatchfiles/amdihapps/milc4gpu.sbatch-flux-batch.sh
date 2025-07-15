#!/bin/bash
#FLUX: --job-name=reclusive-soup-9636
#FLUX: -c=8
#FLUX: --priority=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/milc_c30ed15e1.sif /bin/bash run-benchmark --ngpus 4 -o bench-gpu4.txt
