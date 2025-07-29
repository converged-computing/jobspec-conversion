#!/bin/bash
#SBATCH --job-name=mt08_re80
#SBATCH --account=chertkov
#SBATCH --output=mt08_re80%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=10-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=hi_mem
#SBATCH --array=6

echo "$SLURM_ARRAY_TASK_ID"
module load julia/1.6.1
julia ./main4_${SLURM_ARRAY_TASK_ID}_cont2.jl lf forward 0 unif_tracers 20 600 1
