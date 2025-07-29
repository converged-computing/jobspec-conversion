#!/bin/bash
#SBATCH --job-name=predictvisits_estsmp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20g
#SBATCH --time=02:00:00
#SBATCH --partition=covert-dingel

module load julia/0.6.2
julia predictvisits_estsmp.jl
