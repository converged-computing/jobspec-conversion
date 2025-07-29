#!/bin/bash
#SBATCH --job-name=makefig3
#SBATCH --account=def-stinch
#SBATCH --mail-user=turner.silverthorne@utoronto.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --mem=2500
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

module load matlab/2022b.2
matlab -nodisplay -r "clear; parpool_size=30; popu_size=30; num_pareto_points=10; max_iter=2; makefig3"
