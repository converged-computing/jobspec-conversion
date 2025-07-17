#!/bin/bash
#FLUX: --job-name=stan_pipeline_hr
#FLUX: --queue=shared
#FLUX: -t=43200
#FLUX: --urgency=16

export JULIA_DEPOT_PATH='${HOME}/julia_depots/climate'

export JULIA_DEPOT_PATH="${HOME}/julia_depots/climate"
source ~/julia_modules.sh
cd /n/home04/mrischard/TempModel/batch/
echo "command line arguments"
echo "GPmodel" $1
echo "impute under measurement hour" $2
julia pipeline_hr.jl /n/scratchlfs/pillai_lab/mrischard/temperature_model/saved ${SLURM_ARRAY_TASK_ID} $1 17 $2
