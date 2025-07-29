#!/bin/bash
#SBATCH --account=vminin_lab
#SBATCH --mail-user=igoldst1@uci.edu
#SBATCH --mail-type=begin,end
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=standard
#SBATCH --array=1-2

module purge
module load julia-1_8_5
cd //dfs6/pub/igoldst1/ww_paper
sim_num=1
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/process_results_array_eir_cases.sh
fi
julia --project --threads 4 scripts/generate_quantities/eir_cases_generate_pp_and_gq.jl $sim_num $SLURM_ARRAY_TASK_ID
