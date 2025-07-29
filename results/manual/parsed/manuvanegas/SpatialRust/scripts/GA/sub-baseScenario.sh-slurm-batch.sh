#!/bin/bash
#SBATCH --job-name=debug-basescen
#SBATCH --output=logs/GA/b-%A.o
#SBATCH --error=logs/GA/b-%A.e
#SBATCH --mail-user=mvanega1@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:15:00

module purge
module load julia/1.9.0
echo `date +%F-%T`
julia ~/SpatialRust/scripts/GA/runBaseScenario.jl
