#!/bin/bash
#SBATCH --job-name=run
#SBATCH --account=CCR24006
#SBATCH --output=run.o%j
#SBATCH --error=run.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

cd /work/07016/cw38637/ls6/nlp/
module load cuda/12.2
torchrun --nproc_per_node 1 llama3_generation.py
