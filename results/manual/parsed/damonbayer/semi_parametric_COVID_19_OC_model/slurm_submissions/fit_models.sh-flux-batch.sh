#!/bin/bash
#FLUX: --job-name=swampy-fudge-1436
#FLUX: --urgency=16

module purge
module load julia/1.8.5
cd //pub/bayerd/semi_parametric_COVID_19_OC_model/
julia --project --threads 1 scripts/fit_model.jl $SLURM_ARRAY_TASK_ID
