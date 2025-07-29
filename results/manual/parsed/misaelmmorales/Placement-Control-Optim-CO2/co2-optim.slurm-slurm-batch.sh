#!/bin/bash
#SBATCH --job-name=CO2optim
#SBATCH --account=EAR23030
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --mail-user=misaelmorales@utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=normal

pwd
date
module load matlab
matlab hpcRunner
