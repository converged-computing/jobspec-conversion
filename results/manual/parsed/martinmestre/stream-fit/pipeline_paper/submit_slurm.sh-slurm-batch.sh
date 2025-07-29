#!/bin/bash
#SBATCH --job-name=m56
#SBATCH --output=short_test.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=64

ulimit -l unlimited
julia test_slurm_manager.jl
