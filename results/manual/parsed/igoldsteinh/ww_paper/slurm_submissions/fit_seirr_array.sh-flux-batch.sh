#!/bin/bash
#FLUX: --job-name=conspicuous-bits-5543
#FLUX: --priority=16

module purge
module load julia-1_8_5
cd //dfs6/pub/igoldst1/ww_paper
sim_num=1
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/generate_ppgq_array_seirr.sh
fi
julia --project --threads 4 scripts/fit_models/fit_seirr_student.jl $sim_num $SLURM_ARRAY_TASK_ID
