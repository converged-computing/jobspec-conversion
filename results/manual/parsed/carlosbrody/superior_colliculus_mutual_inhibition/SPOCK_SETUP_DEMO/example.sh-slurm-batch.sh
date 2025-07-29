#!/bin/bash
#SBATCH --job-name=julia-example
#SBATCH --output=log-julia-example-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=00:10:00

echo "I'm alive!" >> imalive.txt
module load julia/1.2.0
module load
julia example.jl
