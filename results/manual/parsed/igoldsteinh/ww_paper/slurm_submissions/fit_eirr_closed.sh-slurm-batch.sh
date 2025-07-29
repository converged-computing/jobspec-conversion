#!/bin/bash
#SBATCH --account=vminin_lab
#SBATCH --mail-user=igoldst1@uci.edu
#SBATCH --mail-type=begin,end
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

module purge
module load julia-1_8_5
cd //dfs6/pub/igoldst1/ww_paper
sim_num=1
julia --project --threads 4 scripts/fit_models/fit_eirr_closed.jl $sim_num
sbatch --depend=afterany:$SLURM_JOB_ID slurm_submissions/generate_pp_and_gq_eirr_closed.sh
