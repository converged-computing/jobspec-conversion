#!/bin/bash
#FLUX: --job-name=scaling_daxpy_cpu
#FLUX: --exclusive
#FLUX: --queue=normal
#FLUX: -t=1200
#FLUX: --priority=16

export JULIA_DEPOT_PATH=':/scratch/hpc-lco-usrtr/.julia_ucl'

ml r
ml lang/JuliaHPC/1.10.0-foss-2022a-CUDA-11.7.0 
export JULIA_DEPOT_PATH=:/scratch/hpc-lco-usrtr/.julia_ucl
julia --project -t 128 scaling_daxpy_cpu.jl
