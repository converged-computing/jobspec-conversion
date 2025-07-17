#!/bin/bash
#FLUX: --job-name=65536M_julia_32_16
#FLUX: --queue=batch
#FLUX: -t=28800
#FLUX: --urgency=16

M=65536 # 2^16
PROJDIR=../../julia/GemmDenseThreads
EXECUTABLE=$PROJDIR/gemm-dense-threads.jl
threads=( 32 16 )
for t in "${threads[@]}"; do
  start_time=$(date +%s)
  srun -n 1 --ntasks-per-node=1 -c $t julia -O3 -t $t --project=$PROJDIR $EXECUTABLE $M $M $M
  end_time=$(date +%s)
  # elapsed time with second resolution
  elapsed=$(( end_time - start_time ))
  echo simple-gemm language=julia compiler=1.8.0-rc1 size=$M threads=$t time=$elapsed "seconds"
done
