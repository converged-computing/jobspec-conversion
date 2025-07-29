#!/bin/bash
#SBATCH --job-name=trefle-prediction
#SBATCH --output=%x-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=2300M
#SBATCH --time=02:00:00
#SBATCH --array=1-829

module load StdEnv/2020 julia/1.5.2
julia --project -t 38 02_imputation.jl
