#!/bin/bash
#FLUX: --job-name=muffled-earthworm-4663
#FLUX: --priority=16

export JULIA_MPIEXEC='srun'
export JULIA_AMDGPU_DISABLE_ARTIFACTS='1 '

M=60000
REPETITIONS=5
PROJDIR=../../simple-gemm/julia/GemmDenseAMDGPU
EXECUTABLE=$PROJDIR/gemm-dense-amdgpu.jl
module load rocm cray-mpich
export JULIA_MPIEXEC=srun
export JULIA_AMDGPU_DISABLE_ARTIFACTS=1 
echo "ROCM_VISIBLE_DEVICES= " $ROCR_VISIBLE_DEVICES
start_time=$(date +%s)
srun -n 1 --gpus=1 julia --project=$PROJDIR $EXECUTABLE $M $M $M $REPETITIONS
end_time=$(date +%s)
elapsed=$(( end_time - start_time ))
echo simple-gemm language=julia compiler=1.8.0-rc1 size=$M gpu time=$elapsed "seconds"
