#!/bin/bash
#SBATCH --job-name=stan_pipeline_hr
#SBATCH --mail-user=mrischard@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=12:00:00
#SBATCH --array=1-119

export JULIA_DEPOT_PATH='${HOME}/julia_depots/climate'

export JULIA_DEPOT_PATH="${HOME}/julia_depots/climate"
source ~/julia_modules.sh
cd /n/home04/mrischard/TempModel/batch/
echo "command line arguments"
echo "GPmodel" $1
echo "impute under measurement hour" $2
julia pipeline_hr.jl /n/scratchlfs/pillai_lab/mrischard/temperature_model/saved ${SLURM_ARRAY_TASK_ID} $1 17 $2
