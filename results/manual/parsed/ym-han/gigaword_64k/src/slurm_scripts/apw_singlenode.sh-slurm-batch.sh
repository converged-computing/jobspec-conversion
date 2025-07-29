#!/bin/bash
#SBATCH --job-name=apw_single
#SBATCH --output=apw_single.%j.%N.out
#SBATCH --error=apw_single.%j.err
#SBATCH --mail-user=yongming_han@brown.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=08:00:00

module load julia/1.5.0
cd /users/yh31/scratch/projects/gigaword_64k/
julia --project=@. /users/yh31/scratch/projects/gigaword_64k/src/apw_mapper_single.jl
