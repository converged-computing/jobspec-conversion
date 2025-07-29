#!/bin/bash
#SBATCH --account=vminin_lab
#SBATCH --output=3_gen_pp_gq-%A-%a.out
#SBATCH --mail-user=bayerd@uci.edu
#SBATCH --mail-type=begin,end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3G
#SBATCH --time=04:00:00
#SBATCH --array=1-64

module purge
module load julia/1.8.5
cd //dfs6/pub/bayerd/covid_SEIHR_county
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/4_tidy_pp_gq.sh
fi
julia --project scripts/generate_posterior_predictive_and_generated_quantities.jl $SLURM_ARRAY_TASK_ID
