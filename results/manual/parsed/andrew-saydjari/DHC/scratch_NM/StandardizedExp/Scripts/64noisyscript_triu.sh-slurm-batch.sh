#!/bin/bash
#SBATCH --job-name=64_noisy
#SBATCH --account=finkbeiner_lab
#SBATCH --output=../Nx64/noisy_stdtrue/SFDTargSFDCov/reg_apd_noiso/LambdaVary/%a_tunedlam_0-01_triu_diag_%A.o
#SBATCH --error=../Nx64/noisy_stdtrue/SFDTargSFDCov/reg_apd_noiso/LambdaVary/%a_tunedlam_0-01_triu_diag_%A.e
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000
#SBATCH --time=00:20:00
#SBATCH --partition=shared

module load Julia/1.5.3-linux-x86_64
julia lambda_runexp_triu.jl "reg" "apd" "noiso" "../Nx64/noisy_stdtrue/" "_tunedlam_0-01_diag_triu" "Diagonal+Eps"
