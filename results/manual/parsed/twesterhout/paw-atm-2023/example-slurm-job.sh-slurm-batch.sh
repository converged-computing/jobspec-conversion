#!/bin/bash
#SBATCH --job-name=64_matrixVectorProduct
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=128
#SBATCH --time=01:00:00
#SBATCH --exclusive
#SBATCH --exclude=tcn377

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
