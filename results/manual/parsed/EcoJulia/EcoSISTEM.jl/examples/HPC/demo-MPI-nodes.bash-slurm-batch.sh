#!/bin/bash
#SBATCH --account=project0000
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=256G
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=8

export OMP_NUM_THREADS='1'
export JULIA_NUM_THREADS='8'

module load apps/julia
module load mpi/openmpi
julia --project=examples -e 'using Pkg; Pkg.instantiate(); Pkg.build("MPI"); using MPI; MPI.install_mpiexecjl(destdir = "bin", force = true)'
export OMP_NUM_THREADS=1
export JULIA_NUM_THREADS=8
bin/mpiexecjl --project=examples -n 32 julia -t 8 --project=examples examples/HPC/MPIRun.jl
