#!/bin/bash
#SBATCH --job-name=rstudio-server
#SBATCH --output=rstudio-%u.%j.out
#SBATCH --error=rstudio-%u.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5gb
#SBATCH --time=03:00:00
#SBATCH --partition=high

module load spack/R/4.1.1
module load rstudio-server/2022.07.1
rserver-farm
