#!/bin/bash
#SBATCH --job-name=double_drake
#SBATCH --output=double_drake.out
#SBATCH --error=double_drake.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --partition=v100

export RESOLUTION='3 '
export NZ='50'
export EXPERIMENT='DoubleDrake'
export PRECISION='Float64'
export LOADBALANCE='0'
export PROFILE='1'
export NNODES='2'
export RESTART=''
export JULIA_CUDA_MEMORY_POOL='none'
export JULIA='julia'
export JULIA_NVTX_CALLBACKS='gc'

export RESOLUTION=3 
export NZ=50
export EXPERIMENT="DoubleDrake"
export PRECISION="Float64"
export LOADBALANCE=0
export PROFILE=1
export NNODES=2
export RESTART=""
export JULIA_CUDA_MEMORY_POOL=none
export JULIA=julia
export JULIA_NVTX_CALLBACKS=gc
julia --project --check-bounds=no experiments/run.jl
nsys profile --trace=nvtx,cuda --output=./lowres julia --project --check-bounds=no experiments/run.jl
