#!/bin/bash
#FLUX: --job-name=tart-pastry-3390
#FLUX: --urgency=16

module purge
module load julia-1_8_5
cd //dfs6/pub/igoldst1/wastewater2
sim_num=1
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/process_results_array_eirr.sh
fi
julia --project --threads 4 scripts/generate_quantities/eirrc_closed_generate_pp_and_gq.jl $sim_num $SLURM_ARRAY_TASK_ID
