#!/bin/bash
#SBATCH --output=logs/dsmc_job_%j.out
#SBATCH --error=logs/dsmc_job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2048
#SBATCH --time=00:08:00
#SBATCH --partition=shared

echo "running...."
julia RunCells.jl -l 0.005
