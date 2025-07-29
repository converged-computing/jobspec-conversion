#!/bin/bash
#SBATCH --job-name=tmle3mediate-simulation
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module load r/3.6.3
module load r-packages
R CMD BATCH --no-save 03_run_simulation.R
