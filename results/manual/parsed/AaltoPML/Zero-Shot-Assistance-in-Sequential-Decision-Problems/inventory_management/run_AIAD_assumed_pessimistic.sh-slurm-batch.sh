#!/bin/bash
#SBATCH --job-name=E0_IM_AIAD_pess
#SBATCH --output=/scratch/work/%u/E0_IM_AIAD_pess_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6000
#SBATCH --time=06:00:00
#SBATCH --array=1-20

module load julia
srun julia AIADExperiment.jl "inventory_experiment/E0_AIAD_assumed_pessimistic_${SLURM_ARRAY_TASK_ID}.jld" inventory_experiment/E0_not_modeled_assumed_pessimistic.jld ${SLURM_ARRAY_TASK_ID}
