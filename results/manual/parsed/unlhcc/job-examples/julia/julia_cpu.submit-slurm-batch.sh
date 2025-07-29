#!/bin/bash
#SBATCH --job-name=julia_cpu_example
#SBATCH --output=julia_example.%J.out
#SBATCH --error=julia_example.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=00:30:00

module load julia/1.9 cuda/12.2 
julia julia_cpu.jl
