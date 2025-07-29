#!/bin/bash
#SBATCH --job-name=kernel
#SBATCH --output=kernel.out
#SBATCH --error=kernel.err
#SBATCH --nodes=1
#SBATCH --ntasks=224
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00

cd $SCRATCH/jobs
module purge
module load openmpi
julia="$PROJECT/julia-1.6.1/bin/julia"
mpirun $julia -e 'const HOME = ENV["HOME"]; include("$HOME/HelioseismicKernels/computekernel.jl")'
