#!/bin/bash
#SBATCH --job-name=calc_max
#SBATCH --account=iidd
#SBATCH --output=logs/slurm_calc_max.out
#SBATCH --mail-user=mhines@usgs.gov
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20GB
#SBATCH --time=00:45:00
#SBATCH --partition=UV,normal

module load R/3.6.1
module load netcdf
srun Rscript src/calc_max.R
