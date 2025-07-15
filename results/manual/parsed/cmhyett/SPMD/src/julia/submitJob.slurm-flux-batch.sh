#!/bin/bash
#FLUX: --job-name=SPMD
#FLUX: -n=6
#FLUX: --queue=standard
#FLUX: -t=3600
#FLUX: --priority=16

module load julia
PROJECT_PATH=${HOME}/SPMD/src/julia/
OUTPUT_PATH=${PROJECT_PATH}/results/${SLURM_ARRAY_TASK_ID}/
MAX_EPOCHS=500
julia --project=${PROJECT_PATH} ${PROJECT_PATH}/runScript.jl ${OUTPUT_PATH} ${MAX_EPOCHS}
