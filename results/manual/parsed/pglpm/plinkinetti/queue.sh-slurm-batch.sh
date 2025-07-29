#!/bin/bash
#SBATCH --job-name=plinkinetti
#SBATCH --output=plinkinetti_%A.out
#SBATCH --error=plinkinetti_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=10000

srun Rscript job.R
