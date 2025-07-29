#!/bin/bash
#SBATCH --job-name=several_div
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --mail-user=mroswell.rutgers@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=192GB
#SBATCH --time=3-00:00:00
#SBATCH --array=0-23

module load intel/17.0.4
module load R-Project/3.4.1
Rscript scripts/asy_SAD$SLURM_ARRAY_TASK_ID.R 
