#!/bin/bash
#SBATCH --job-name=SPMD
#SBATCH --account=${ACCOUNT}
#SBATCH --output=%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4gb
#SBATCH --time=01:00:00
#SBATCH --array=1-10

module load julia
PROJECT_PATH=${HOME}/SPMD/src/julia/
OUTPUT_PATH=${PROJECT_PATH}/results/${SLURM_ARRAY_TASK_ID}/
MAX_EPOCHS=500
julia --project=${PROJECT_PATH} ${PROJECT_PATH}/runScript.jl ${OUTPUT_PATH} ${MAX_EPOCHS}
