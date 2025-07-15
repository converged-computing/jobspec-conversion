#!/bin/bash
#FLUX: --job-name=dirty-pancake-6381
#FLUX: --urgency=16

export JULIA_MPIEXEC='srun'
export JULIA_AMDGPU_DISABLE_ARTIFACTS='1'

PROJDIR=../../simple-gemm/julia/GemmDenseAMDGPU
EXECUTABLE=$PROJDIR/gemm-dense-amdgpu.jl
REPETITIONS=5
module load rocm/5.2.0 cray-mpich
rocminfo | grep GPU
export JULIA_MPIEXEC=srun
export JULIA_AMDGPU_DISABLE_ARTIFACTS=1
echo "ROCM_VISIBLE_DEVICES= " $ROCR_VISIBLE_DEVICES
Ms=( 4096 5120 6144 7168 8192 9216 10240 11264 12288 13312 14336 15360 16384 17408 18432 19456 20480 )
for M in "${Ms[@]}"; do
  start_time=$(date +%s)
  srun -n 1 --gpus=1 julia -O3 --project=$PROJDIR $EXECUTABLE $M $M $M $REPETITIONS
  end_time=$(date +%s)
  # elapsed time with second resolution
  elapsed=$(( end_time - start_time ))
  echo simple-gemm language=julia compiler=1.8.0-rc1 size=$M gpu time=$elapsed "seconds"
done
