#!/bin/bash
#SBATCH --job-name=E0_IRL_IM_OPT_30
#SBATCH --output=/scratch/work/%u/E0_IRL_IM_OPT_30_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1500
#SBATCH --time=02:30:00
#SBATCH --array=1-20

STEP=30
module load julia
srun julia Automate.jl "inventory_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}_OPT_${STEP}.jld" inventory_experiment/E0_modeled.jld "inventory_experiment/E0_IRL_${SLURM_ARRAY_TASK_ID}.jld" ${STEP}
