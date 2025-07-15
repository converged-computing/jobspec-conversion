#!/bin/bash
#FLUX: --job-name=tart-caramel-7993
#FLUX: --urgency=16

module purge
module load julia/1.8.5
cd //dfs6/pub/bayerd/covid_SEIHR_county
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/3_gen_pp_gq.sh
fi
julia --project --threads 4 scripts/fit_model.jl $SLURM_ARRAY_TASK_ID
