#!/bin/bash
#SBATCH --job-name=64_noisy
#SBATCH --account=finkbeiner_lab
#SBATCH --output=../Nx64/noisy_stdtrue/SFDTargSFDCov/log_apd_noiso/nophi_lamcorr_try1_%A_%a.o
#SBATCH --error=../Nx64/noisy_stdtrue/SFDTargSFDCov/log_apd_noiso/nophi_lamcorr_try1_%A_%a.e
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
#SBATCH --time=00:30:00
#SBATCH --partition=test

module load Julia/1.5.3-linux-x86_64
julia runexp_nophi.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/"
