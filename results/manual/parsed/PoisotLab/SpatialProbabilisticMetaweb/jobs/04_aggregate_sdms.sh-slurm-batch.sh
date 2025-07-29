#!/bin/bash
#SBATCH --job-name=04_aggregate_sdms
#SBATCH --account=ctb-tpoisot
#SBATCH --output=jobs/out/%x-%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=48G
#SBATCH --time=00:17:00

module load StdEnv/2020
module load julia/1.9.1
cd $HOME/projects/def-tpoisot/2022-SpatialProbabilisticMetaweb/
julia --project --threads=63 -e 'CAN = true; quiet = true; include("04_aggregate_sdms.jl")'
