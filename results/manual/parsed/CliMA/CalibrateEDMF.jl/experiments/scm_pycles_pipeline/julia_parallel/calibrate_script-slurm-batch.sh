#!/bin/bash
#SBATCH --job-name=ekp_bomex
#SBATCH --output=slurm_julia_par_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=6G
#SBATCH --time=02:00:00

config=${1?Error: no config file given}
module purge
module load julia/1.10.1
julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.API.precompile()'
julia --project -p 10 calibrate.jl --config $config
