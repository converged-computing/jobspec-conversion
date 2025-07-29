#!/bin/bash
#SBATCH --job-name=helloWorld
#SBATCH --output=helloWorld.out
#SBATCH --error=helloWorld.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module load gcc/12.2
module load R/4.2.2
Rscript ../NWSimulation.R
