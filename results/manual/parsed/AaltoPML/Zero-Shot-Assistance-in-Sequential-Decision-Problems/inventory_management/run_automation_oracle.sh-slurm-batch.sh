#!/bin/bash
#SBATCH --job-name=E0_IM_ORACLE
#SBATCH --output=/scratch/work/%u/E0_IM_ORACLE_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000
#SBATCH --time=01:00:00
#SBATCH --array=1-20

module load julia
srun julia AutomateOracle.jl "inventory_experiment/E0_ORACLE_${SLURM_ARRAY_TASK_ID}.jld" inventory_experiment/E0_modeled.jld ${SLURM_ARRAY_TASK_ID}
