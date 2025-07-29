#!/bin/bash
#SBATCH --output=r_array_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500M
#SBATCH --time=00:30:00
#SBATCH --array=1-100

module load matlab
srun matlab -nodisplay -r serial
