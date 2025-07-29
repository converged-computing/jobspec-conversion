#!/bin/bash
#SBATCH --job-name=cc
#SBATCH --output=crosscov.out
#SBATCH --error=crosscov.err
#SBATCH --nodes=1
#SBATCH --ntasks=56
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

cd $SCRATCH/jobs
module purge
module load openmpi
julia="$PROJECT/julia-1.6.1/bin/julia"
mpirun $julia -e 'const HOME = ENV["HOME"]; include("$HOME/HelioseismicKernels/computecrosscov.jl")'
