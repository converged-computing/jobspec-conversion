#!/bin/bash
#SBATCH --job-name=NS
#SBATCH --output=ns_%j.log
#SBATCH --mail-user=luke.morris@ufl.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32gb
#SBATCH --time=08:00:00

export JULIA_DEPOT_PATH='/blue/fairbanksj/fairbanksj/jldepot'

pwd; hostname; date
module load julia
mkdir -p "/blue/fairbanksj/fairbanksj/jldepot"
export JULIA_DEPOT_PATH="/blue/fairbanksj/fairbanksj/jldepot"
echo "JULIA_DEPOT_PATH:"
echo "$JULIA_DEPOT_PATH"
echo "Launching script"
date
julia --threads=auto --proj=. -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
julia --threads=auto --proj=. ./ns.jl
date
echo "Exiting script"
