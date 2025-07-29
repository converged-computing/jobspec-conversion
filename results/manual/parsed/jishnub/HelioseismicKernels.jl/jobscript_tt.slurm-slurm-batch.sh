#!/bin/bash
#SBATCH --job-name=tt
#SBATCH --output=traveltime.out
#SBATCH --error=traveltime.err
#SBATCH --nodes=1
#SBATCH --ntasks=56
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00

cd $SCRATCH/jobs
julia="$PROJECT/julia-1.6.1/bin/julia"
module purge
module load openmpi
$julia -e 'include("$(ENV["HOME"])/HelioseismicKernels/compute_traveltimes.jl")'
