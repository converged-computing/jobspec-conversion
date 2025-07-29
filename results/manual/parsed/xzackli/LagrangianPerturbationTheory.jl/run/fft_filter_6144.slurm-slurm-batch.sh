#!/bin/bash
#SBATCH --job-name=fullresfilter_debug
#SBATCH --account=mp107d
#SBATCH --output=/pscratch/sd/x/xzackli/joboutput/%x.o%j
#SBATCH --mail-user=zackli@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:30:00
#SBATCH --qos=debug
#SBATCH --exclusive
#SBATCH --constraint=cpu,ntasks-per-node=16

export JULIA_NUM_THREADS='8'

cd /pscratch/sd/x/xzackli/websky_convert/LagrangianPerturbationTheory.jl/run/
module load cray-mpich
module load cray-hdf5-parallel
export JULIA_NUM_THREADS=8
which julia
julia --project=. -e \
    'using Pkg; using InteractiveUtils;
     Pkg.instantiate(); Pkg.precompile(); Pkg.status(); versioninfo();
     using MPI; println("MPI: ", MPI.identify_implementation());'
/global/homes/x/xzackli/.julia/bin/mpiexecjl --project=. --cpu-bind=cores julia fft_filter_6144.jl
