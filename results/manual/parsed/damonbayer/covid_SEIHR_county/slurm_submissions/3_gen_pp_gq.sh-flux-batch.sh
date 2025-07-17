#!/bin/bash
#FLUX: --job-name=milky-lizard-7825
#FLUX: --queue=stats.p
#FLUX: -t=14400
#FLUX: --urgency=16

cd /home/abakis/git/covid_SEIHR_county
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/4_tidy_pp_gq.sh
fi
julia +1.8 --project scripts/generate_posterior_predictive_and_generated_quantities.jl $SLURM_ARRAY_TASK_ID
