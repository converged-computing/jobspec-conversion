#!/bin/bash
#FLUX: --job-name=delicious-latke-2338
#FLUX: --priority=16

cd /home/abakis/git/covid_SEIHR_county
Rscript scripts/tidy_posterior_predictive_and_generated_quantities.R
sbatch --depend=afterany:$SLURM_JOB_ID slurm_submissions/5a_calcat.sh
sbatch --depend=afterany:$SLURM_JOB_ID slurm_submissions/5b_figures.sh
