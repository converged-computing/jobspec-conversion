#!/bin/bash
#FLUX: --job-name=salted-cattywampus-4367
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.3.0
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/rocm_5.3.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 0 &
singularity run /shared/apps/bin/rocm_5.3.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 1 &
wait
