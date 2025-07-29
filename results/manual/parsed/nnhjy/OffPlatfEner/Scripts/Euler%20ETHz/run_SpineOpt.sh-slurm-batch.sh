#!/bin/bash
#SBATCH --job-name=runSpineOpt
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=2-00:00:00

module load gurobi gcc/11.4.0 julia/1.10.2
cd $SCRATCH/path/to/the/SpineOptProject
julia ./path/to/run_SpineOpt.jl
