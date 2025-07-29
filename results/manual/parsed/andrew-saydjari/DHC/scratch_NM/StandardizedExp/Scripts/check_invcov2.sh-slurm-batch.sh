#!/bin/bash
#SBATCH --job-name=64_noisy
#SBATCH --account=finkbeiner_lab
#SBATCH --output=../Nx64/noisy_stdtrue/SFDTargSFDCov/reg_apd_noiso/check_triu_diag_%A.o
#SBATCH --error=../Nx64/noisy_stdtrue/SFDTargSFDCov/reg_apd_noiso/check_triu_diag_%A.e
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
#SBATCH --time=00:20:00

module load Julia/1.5.3-linux-x86_64
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Diagonal"
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Full"
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Diagonal+Eps"
julia Check_Invcov_Logcoeff.jl "log" "apd" "noiso" "../Nx64/noisy_stdtrue/" "checks" "Full+Eps"
