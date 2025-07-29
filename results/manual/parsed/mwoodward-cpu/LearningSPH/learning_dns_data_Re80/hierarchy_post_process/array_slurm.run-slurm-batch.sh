#!/bin/bash
#SBATCH --job-name=mt08_node
#SBATCH --account=chertkov
#SBATCH --output=mt08_node%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --constraint=hi_mem
#SBATCH --array=1-5

echo "$SLURM_ARRAY_TASK_ID"
module load julia/1.6.1
julia ./hpc_code/running_trained_models_long_t_generalization_t50_lf_${SLURM_ARRAY_TASK_ID}.jl 
