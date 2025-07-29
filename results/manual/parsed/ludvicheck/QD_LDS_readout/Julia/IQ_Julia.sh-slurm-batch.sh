#!/bin/bash
#SBATCH --job-name=iq_julia_job
#SBATCH --output=logs/iq_julia_job-%J.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=800G
#SBATCH --time=23:00:00

module load SciPy-bundle
module load mosek
module load Julia
cd /mnt/personal/cignalud/QD_LDS_readout/Julia
julia IQ_Julia_script.jl
