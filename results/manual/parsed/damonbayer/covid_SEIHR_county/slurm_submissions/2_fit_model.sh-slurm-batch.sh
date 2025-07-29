#!/bin/bash
#SBATCH --output=log/%x.%A.out
#SBATCH --error=log/%x.%A.err
#SBATCH --mail-user=abakis@uci.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=5G
#SBATCH --time=3-00:00:00
#SBATCH --array=1-64
#SBATCH --exclude=stats-5

cd /home/abakis/git/covid_SEIHR_county
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/3_gen_pp_gq.sh
fi
julia +1.8 --project --threads 4 scripts/fit_model.jl $SLURM_ARRAY_TASK_ID
