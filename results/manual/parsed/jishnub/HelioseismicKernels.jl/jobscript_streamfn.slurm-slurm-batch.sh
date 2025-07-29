#!/bin/bash
#SBATCH --job-name=ttstrmfn
#SBATCH --output=streamfn.out
#SBATCH --error=streamfn.err
#SBATCH --nodes=1
#SBATCH --ntasks=56
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

cd $SCRATCH/jobs
julia="$PROJECT/julia-1.6.1/bin/julia"
module purge
module load openmpi
$julia -e 'include("$(ENV["HOME"])/HelioseismicKernels/streamfn_traveltimes.jl")'
