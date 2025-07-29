#!/bin/bash
#SBATCH --job-name=Ndopt
#SBATCH --output=cluster_output/Ndopt%j.out
#SBATCH --error=cluster_output/Ndopt%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64GB
#SBATCH --time=20:00:00

export PATH='~/Applications/julia-1.6.2/bin:$PATH'
export LD_LIBRARY_PATH='~/Applications/julia-1.6.2/lib'

export PATH=~/Applications/julia-1.6.2/bin:$PATH
export LD_LIBRARY_PATH=~/Applications/julia-1.6.2/lib
cd /home/geovault-06/pasquier/Projects/GNOM
julia src/Nd_model/setup_and_optimization.jl
