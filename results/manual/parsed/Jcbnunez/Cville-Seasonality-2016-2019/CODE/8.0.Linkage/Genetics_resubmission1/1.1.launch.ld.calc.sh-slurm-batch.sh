#!/bin/bash
#SBATCH --job-name=r2.ag
#SBATCH --output=./slurmOutput/r2.%A_%a.out
#SBATCH --error=./slurmOutput/r2.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=50G
#SBATCH --time=20:00:00

module load spack/spack-0.18.1
spack load r@4.2.1 r-sf
Rscript \
--vanilla \
1.0.calculate_linkage_w_inversion.r
date
echo "done"
