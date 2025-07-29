#!/bin/bash
#SBATCH --job-name=baseline_coverage
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=25
#SBATCH --mem=192GB
#SBATCH --time=03:00:00
#SBATCH --partition=main

module load intel/17.0.4
module load R-Project/3.4.1
srun Rscript scripts/actual_diversity_coverage.R 
