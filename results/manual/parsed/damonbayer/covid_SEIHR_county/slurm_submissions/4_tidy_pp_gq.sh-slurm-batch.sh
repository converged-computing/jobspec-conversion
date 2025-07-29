#!/bin/bash
#SBATCH --output=log/%x.%A.out
#SBATCH --error=log/%x.%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=60G
#SBATCH --time=04:00:00

cd /home/abakis/git/covid_SEIHR_county
Rscript scripts/tidy_posterior_predictive_and_generated_quantities.R
sbatch --depend=afterany:$SLURM_JOB_ID slurm_submissions/5a_calcat.sh
sbatch --depend=afterany:$SLURM_JOB_ID slurm_submissions/5b_figures.sh
