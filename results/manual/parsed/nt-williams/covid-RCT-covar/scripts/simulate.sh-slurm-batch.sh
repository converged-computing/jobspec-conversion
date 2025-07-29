#!/bin/bash
#SBATCH --job-name=covidRCT
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=24G
#SBATCH --array=1-1000

echo "$SLURM_ARRAY_TASK_ID"
source ~/.bashrc
spack load -r /bxc56dm
Rscript simulate.R ${1}
exit 0
