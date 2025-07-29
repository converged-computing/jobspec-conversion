#!/bin/bash
#SBATCH --job-name=testperms
#SBATCH --account=def-stinch
#SBATCH --mail-user=turner.silverthorne@utoronto.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=2000
#SBATCH --time=00:02:00

module load matlab/2022b.2
matlab -nodisplay -r "testgpu"
