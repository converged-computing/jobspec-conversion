#!/bin/bash
#FLUX: --job-name=mpi_bcast
#FLUX: -c=128
#FLUX: --exclusive
#FLUX: --queue=all
#FLUX: -t=300
#FLUX: --priority=16

export JULIA_DEPOT_PATH=':/scratch/hpc-lco-usrtr/.julia_ucl'
export SLURM_EXPORT_ENV='ALL'

ml r
ml lang/JuliaHPC/1.10.0-foss-2022a-CUDA-11.7.0
export JULIA_DEPOT_PATH=:/scratch/hpc-lco-usrtr/.julia_ucl
export SLURM_EXPORT_ENV=ALL
N=268435456
mpiexecjl --project -n 32 julia ../mpi_bcast_builtin.jl $N
mpiexecjl --project -n 32 julia ../mpi_bcast_tree.jl $N
mpiexecjl --project -n 32 julia ../mpi_bcast_sequential.jl $N
