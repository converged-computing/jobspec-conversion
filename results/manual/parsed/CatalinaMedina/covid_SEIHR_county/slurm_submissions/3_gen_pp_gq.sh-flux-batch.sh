#!/bin/bash
#FLUX: --job-name=wobbly-car-3425
#FLUX: --urgency=16

module purge
module load julia/1.8.5
cd //dfs6/pub/bayerd/covid_SEIHR_county
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/4_tidy_pp_gq.sh
fi
julia --project scripts/generate_posterior_predictive_and_generated_quantities.jl $SLURM_ARRAY_TASK_ID
