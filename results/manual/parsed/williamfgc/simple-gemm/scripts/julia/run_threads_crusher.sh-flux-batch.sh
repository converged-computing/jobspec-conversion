#!/bin/bash
#FLUX: --job-name=boopy-peanut-butter-5497
#FLUX: --urgency=16

export JULIA_MPIEXEC='srun'
export JULIA_EXCLUSIVE='1'

!/bin/bash
PROJDIR=../../simple-gemm/julia/GemmDenseThreads
EXECUTABLE=$PROJDIR/gemm-dense-threads.jl
module load cray-mpich
export JULIA_MPIEXEC=srun
export JULIA_EXCLUSIVE=1
Ms=( 4096 5120 6144 7168 8192 9216 10240 11264 12288 13312 14336 15360 16384 17408 18432 19456 20480 )
threads=64
for M in "${Ms[@]}"; do
  start_time=$(date +%s)
  srun -n 1 -c $threads julia -O3 --project=$PROJDIR -t $threads $EXECUTABLE $M $M $M 5
  end_time=$(date +%s)
  # elapsed time with second resolution
  elapsed=$(( end_time - start_time ))
  echo simple-gemm language=julia compiler=1.8.0-rc1 size=$M cpu time=$elapsed "seconds"
done
