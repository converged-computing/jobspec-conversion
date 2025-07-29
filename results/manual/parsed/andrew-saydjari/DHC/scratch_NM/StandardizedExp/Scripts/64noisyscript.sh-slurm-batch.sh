#!/bin/bash
#SBATCH --job-name=64_noisy
#SBATCH --account=finkbeiner_lab
#SBATCH --output=../Nx64/noisy_stdtrue/SFDTargSFDCov/log_apd_iso/largelamcorr_try1_%A_%a.o
#SBATCH --error=../Nx64/noisy_stdtrue/SFDTargSFDCov/log_apd_iso/largelamcorr_try1_%A_%a.e
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
#SBATCH --time=00:30:00
#SBATCH --partition=test

module load Julia/1.5.3-linux-x86_64
julia runexp.jl "log" "apd" "iso" "../Nx64/noisy_stdtrue/"
