#!/bin/bash
#SBATCH --job-name=E0_TRUE
#SBATCH --output=/scratch/work/%u/E0_TRUE_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=03:00:00
#SBATCH --array=1-75

module load julia
srun julia OptimizeTrueTrip.jl "anchoring_experiment/E0_TRUE_${SLURM_ARRAY_TASK_ID}_OPT.jld" anchoring_experiment/E0_anchoring_experiment_modeled.jld ${SLURM_ARRAY_TASK_ID}
