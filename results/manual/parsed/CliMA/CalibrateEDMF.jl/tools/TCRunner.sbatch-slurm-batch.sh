#!/bin/bash
#SBATCH --job-name=TCRunner
#SBATCH --output=slurm_TCRunner_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00

module purge
module load julia/1.10.1
julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.API.precompile()'
julia -p15 TCRunner.jl "$@"
echo finished
