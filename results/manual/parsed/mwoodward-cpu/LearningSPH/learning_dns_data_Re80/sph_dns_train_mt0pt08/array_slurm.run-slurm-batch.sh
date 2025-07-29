#!/bin/bash
#SBATCH --job-name=mt08_node
#SBATCH --account=chertkov
#SBATCH --output=mt08_node%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=10-00:00:00
#SBATCH --constraint=hi_mem
#SBATCH --array=5-6

echo "$SLURM_ARRAY_TASK_ID"
module load julia/1.6.1
julia ./main4_${SLURM_ARRAY_TASK_ID}.jl lf forward 0 unif_tracers 30 600
