#!/bin/bash
#SBATCH --job-name=julia_lu
#SBATCH --account=csd453
#SBATCH --output=julia_lu.%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=00:30:00
#SBATCH --partition=shared
#SBATCH --constraint=ntasks-per-node=1

export JULIA_NUM_THREADS='32'

module purge
module load slurm
module load cpu
module load gcc
module load julia
export JULIA_NUM_THREADS=32
srun hostname -s > hostfile
sleep 5
julia --machine-file ./hostfile ./luDecomJulia.jl
