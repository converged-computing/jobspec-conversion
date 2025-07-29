#!/bin/bash
#SBATCH --job-name=dbmt_process
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=2000
#SBATCH --time=00:05:00
#SBATCH --partition=fuchs
#SBATCH --array=1-20

srun Rscript sim_stats.R
exit 0
