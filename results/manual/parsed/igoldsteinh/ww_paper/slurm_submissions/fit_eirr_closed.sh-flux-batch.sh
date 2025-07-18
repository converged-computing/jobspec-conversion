#!/bin/bash
#FLUX: --job-name=quirky-mango-9995
#FLUX: -n=4
#FLUX: --queue=standard
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load julia-1_8_5
cd //dfs6/pub/igoldst1/ww_paper
sim_num=1
julia --project --threads 4 scripts/fit_models/fit_eirr_closed.jl $sim_num
sbatch --depend=afterany:$SLURM_JOB_ID slurm_submissions/generate_pp_and_gq_eirr_closed.sh
