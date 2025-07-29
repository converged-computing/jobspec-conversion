#!/bin/bash
#SBATCH --output=slurm-%A-%a.out
#SBATCH --error=slurm-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=2G
#SBATCH --time=06:00:00
#SBATCH --array=2

module load Julia
echo "Julia module loaded."
julia --project=. -e 'include("test.jl")'
echo "Julia test passed."
julia --project=. -e 'import Pkg; Pkg.instantiate(); include("src/run.jl")'
