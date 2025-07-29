#!/bin/bash
#SBATCH --job-name=filament-instability-Ri000
#SBATCH --output=../scratch/logs/filament-instability/Ri000.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module load cuda/11.0.3
cd ~/filament-instability
./../julia-1.8.5/bin/julia -t 8 --project="env" -- src/simulation.jl secondarycirculation parameters/ParameterSweep/Ri000.txt 1 50 100 ../scratch/filament-instability/Ri000
