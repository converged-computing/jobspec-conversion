#!/bin/bash
#SBATCH --job-name=multisess
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=192GB
#SBATCH --time=3-00:00:00
#SBATCH --array=0-23%

module load intel/17.0.4
module load R-Project/3.4.1
at=$SLURM_ARRAY_TASK_ID+1
srun Rscript scripts/obs_lomemSAD$at.R 
