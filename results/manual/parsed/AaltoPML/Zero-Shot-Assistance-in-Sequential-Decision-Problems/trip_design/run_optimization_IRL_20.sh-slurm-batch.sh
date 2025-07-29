#!/bin/bash
#SBATCH --job-name=E0_IRL_OPT_20
#SBATCH --output=/scratch/work/%u/E0_IRL_OPT_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=03:30:00
#SBATCH --array=1-50

STEP=20
module load julia
srun julia OptimizeTrip.jl "basic_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}_OPT_${STEP}_RESTART.jld" basic_experiment/E0_basic_experiment.jld "basic_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}.jld" ${STEP} RESTART
