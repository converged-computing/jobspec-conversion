#!/bin/bash
#FLUX: --job-name=hello-soup-8232
#FLUX: --exclusive
#FLUX: --priority=16

export GASNET_BACKTRACE='1'
export GASNET_PHYSMEM_MAX='167 GB'

set -x
export GASNET_BACKTRACE=1
export GASNET_PHYSMEM_MAX='167 GB'
numLocales=$SLURM_JOB_NUM_NODES
remoteBufferSize=10000
cacheNumberBits=26
numConsumerTasks=24
for chainLength in 40 42; do
  srun --mpi=pmix -N $numLocales -n $numLocales apptainer exec \
    BenchmarkMatrixVectorProduct.sif BenchmarkMatrixVectorProduct \
    --numLocales $numLocales \
    --kHamiltonian data/heisenberg_chain_${chainLength}_symm.yaml \
    --kDisplayTimings=true \
    --kNumConsumerTasks=$numConsumerTasks \
    --kRemoteBufferSize=$remoteBufferSize \
    --kCacheNumberBits=$cacheNumberBits \
    --kFactor=$numLocales
done
