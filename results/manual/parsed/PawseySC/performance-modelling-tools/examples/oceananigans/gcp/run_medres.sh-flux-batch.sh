#!/bin/bash
#FLUX: --job-name=double_drake
#FLUX: -n=2
#FLUX: --queue=v100
#FLUX: --urgency=16

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
nsys profile --trace=nvtx,cuda --output=./medres julia --project --check-bounds=no experiments/run.jl
