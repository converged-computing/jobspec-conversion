#!/bin/bash
#SBATCH --job-name=compile_PerforatedCylinder
#SBATCH --output=stdout_genoa
#SBATCH --error=stderr_genoa
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=genoa

source modules_snellius.sh
julia --project=../ -e 'using Pkg; Pkg.build("MPI")'
mpiexecjl --project=../ -n 1 julia -O3 --check-bounds=no --color=yes compile_genoa.jl
