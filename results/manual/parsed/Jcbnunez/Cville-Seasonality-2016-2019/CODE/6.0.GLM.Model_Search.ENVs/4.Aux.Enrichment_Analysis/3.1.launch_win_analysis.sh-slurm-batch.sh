#!/bin/bash
#SBATCH --job-name=enr.win
#SBATCH --output=./slurmOutput/enr.%A_%a.out
#SBATCH --error=./slurmOutput/enr.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=50G
#SBATCH --time=06:00:00
#SBATCH --partition=bluemoon

module load spack/spack-0.18.1
spack load r@4.2.1 r-sf
Rscript \
--vanilla \
3.Window.level.enrrichment.r
date
echo "done"
