#!/bin/bash
#SBATCH --job-name=exp2
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

echo Hello
sleep 10
echo Starting
module load Julia
stdbuf -o0 -e0 julia  --color=no -O3 cape_explanations.jl  --task $1  #-i $SLURM_ARRAY_TASK_ID
