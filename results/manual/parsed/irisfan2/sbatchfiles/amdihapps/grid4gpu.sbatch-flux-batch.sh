#!/bin/bash
#FLUX: --job-name=crunchy-signal-2145
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/grid.sif mpirun -np 4  /benchmark/gpu_bind.sh Benchmark_ITT --accelerator-threads 8 --mpi 1.1.1.4
