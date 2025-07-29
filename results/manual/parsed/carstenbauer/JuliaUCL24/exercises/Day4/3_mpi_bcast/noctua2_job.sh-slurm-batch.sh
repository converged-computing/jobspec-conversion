#!/bin/bash
#SBATCH --job-name=mpi_bcast
#SBATCH --account=hpc-lco-usrtr
#SBATCH --output=mpi_bcast_job-%A.out
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --time=00:05:00
#SBATCH --partition=normal
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

export JULIA_DEPOT_PATH=':/scratch/hpc-lco-usrtr/.julia_ucl'
export SLURM_EXPORT_ENV='ALL'

ml r
ml lang/JuliaHPC/1.10.0-foss-2022a-CUDA-11.7.0 
export JULIA_DEPOT_PATH=:/scratch/hpc-lco-usrtr/.julia_ucl
export SLURM_EXPORT_ENV=ALL
N=268435456
mpiexecjl --project -n 16 julia mpi_bcast_builtin.jl $N
mpiexecjl --project -n 16 julia mpi_bcast_tree.jl $N
mpiexecjl --project -n 16 julia mpi_bcast_sequential.jl $N
