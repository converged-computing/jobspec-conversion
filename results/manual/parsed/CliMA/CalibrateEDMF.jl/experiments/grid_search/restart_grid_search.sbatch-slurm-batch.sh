#!/bin/bash
#SBATCH --job-name=r_grid
#SBATCH --output=slurm_grid_search_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=25
#SBATCH --cpus-per-task=1
#SBATCH --time=1-06:00:00

outdir=${1?Error: no output directory given}
module purge
module load julia/1.10.1
julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.API.precompile()'
julia --project -p 25 grid_search.jl --outdir $outdir --mode restart
