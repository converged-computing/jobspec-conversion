#!/bin/bash
#SBATCH --account=vminin_lab
#SBATCH --output=2_fit_model-%A-%a.out
#SBATCH --mail-user=bayerd@uci.edu
#SBATCH --mail-type=begin,end
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=5G
#SBATCH --time=04:00:00
#SBATCH --partition=standard
#SBATCH --array=1-64
#SBATCH --exclude=hpc3-15-29,hpc3-21-30

module purge
module load julia/1.8.5
cd //dfs6/pub/bayerd/covid_SEIHR_county
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/3_gen_pp_gq.sh
fi
julia --project --threads 4 scripts/fit_model.jl $SLURM_ARRAY_TASK_ID
