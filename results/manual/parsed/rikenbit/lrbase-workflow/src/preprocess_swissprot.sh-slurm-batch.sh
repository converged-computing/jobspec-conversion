#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --partition=node03-06
#SBATCH --qos=low

SLURM_RESTART_COUNT=2
julia src/preprocess_swissprot.jl $@
