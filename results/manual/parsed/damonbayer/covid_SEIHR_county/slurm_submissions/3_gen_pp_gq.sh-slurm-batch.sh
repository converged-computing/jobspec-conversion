#!/bin/bash
#SBATCH --output=log/%x.%A.out
#SBATCH --error=log/%x.%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3G
#SBATCH --time=04:00:00
#SBATCH --array=1-64

cd /home/abakis/git/covid_SEIHR_county
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/4_tidy_pp_gq.sh
fi
julia +1.8 --project scripts/generate_posterior_predictive_and_generated_quantities.jl $SLURM_ARRAY_TASK_ID
