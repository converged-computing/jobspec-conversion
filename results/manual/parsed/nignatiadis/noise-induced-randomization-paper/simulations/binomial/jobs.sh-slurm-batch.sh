#!/bin/bash
#SBATCH --job-name=noiserdd
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --partition=hns,normal,stat
#SBATCH --array=1-24

ml load gmp
ml load mpfr
ml load R/4.0.2
ml load julia/1.6.2
Rscript simulation.R $SLURM_ARRAY_TASK_ID
