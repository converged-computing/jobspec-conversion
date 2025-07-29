#!/bin/bash
#SBATCH --job-name=64_noisy
#SBATCH --account=finkbeiner_lab
#SBATCH --output=../Nx64/noisy_stdtrue/SFDTargSFDCov/log_apd_noiso/%a_triu_%A.o
#SBATCH --error=../Nx64/noisy_stdtrue/SFDTargSFDCov/log_apd_noiso/%a_triu_%A.e
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
#SBATCH --time=00:20:00

module load Julia/1.5.3-linux-x86_64
julia runexp_triu.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "_triu"
