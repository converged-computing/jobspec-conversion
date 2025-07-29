#!/bin/bash
#SBATCH --job-name=plotting
#SBATCH --output=plot.out
#SBATCH --error=plot.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

module load cuda-11.8.0-gcc-11.2.0-kh2t6kp
julia --project HighResolutionPlot.jl
