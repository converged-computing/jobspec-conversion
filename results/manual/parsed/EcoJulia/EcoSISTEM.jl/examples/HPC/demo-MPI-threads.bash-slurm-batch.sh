#!/bin/bash
#SBATCH --account=project0000
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=256G
#SBATCH --time=12:00:00
#SBATCH --partition=nodes
#SBATCH --constraint=ntasks-per-node=2

export OMP_NUM_THREADS='1'
export JULIA_NUM_THREADS='32'

module load apps/julia
module load mpi/openmpi
julia --project=examples -e 'using Pkg; Pkg.instantiate(); Pkg.build("MPI"); using MPI; MPI.install_mpiexecjl(destdir = "bin", force = true)'
export OMP_NUM_THREADS=1
export JULIA_NUM_THREADS=32
bin/mpiexecjl --project=examples -n 2 julia -t 32 --project=examples examples/HPC/MPIRun.jl
