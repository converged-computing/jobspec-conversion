#!/bin/bash
#SBATCH --job-name=E0_IRL
#SBATCH --output=/scratch/work/%u/E0_IRL_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=08:00:00
#SBATCH --array=1-50

module load julia
srun julia ElicitationExperiment.jl IRL "basic_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}.jld" basic_experiment/E0_basic_experiment.jld ${SLURM_ARRAY_TASK_ID}
