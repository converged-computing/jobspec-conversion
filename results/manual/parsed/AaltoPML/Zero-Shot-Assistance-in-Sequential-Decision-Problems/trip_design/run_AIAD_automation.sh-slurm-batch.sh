#!/bin/bash
#SBATCH --job-name=EL1_AIAD_automate
#SBATCH --output=/scratch/work/%u/EL1_AIAD_automate_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=15:00:00
#SBATCH --array=1-50

module load julia
srun julia AIADExperiment.jl "basic_experiment/E0_AIAD_automate_${SLURM_ARRAY_TASK_ID}.jld" basic_experiment/E0_basic_experiment.jld ${SLURM_ARRAY_TASK_ID} AUTOMATE
