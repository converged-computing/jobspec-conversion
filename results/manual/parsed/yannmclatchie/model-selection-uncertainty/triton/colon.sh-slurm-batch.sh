#!/bin/bash
#SBATCH --output=slurm/real/%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=5-00:00:00
#SBATCH --array=1

module load r
module load gcc/11.2.0
srun Rscript ./R/real-world/colon.R $1 $2
