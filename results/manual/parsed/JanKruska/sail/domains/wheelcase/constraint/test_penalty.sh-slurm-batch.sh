#!/bin/bash
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=160G
#SBATCH --time=02:00:00
#SBATCH --exclusive

export MALLOC_ARENA_MAX='4'

export MALLOC_ARENA_MAX=4
module load java/default
module load cuda/default
module load matlab/R2019b
matlab -batch "test_penalty"
