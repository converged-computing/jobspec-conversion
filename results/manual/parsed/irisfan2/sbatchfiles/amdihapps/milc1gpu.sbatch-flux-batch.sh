#!/bin/bash
#FLUX: --job-name=red-parsnip-8875
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/milc_c30ed15e1.sif /bin/bash run-benchmark --ngpus 1 -o bench-gpu1.txt
