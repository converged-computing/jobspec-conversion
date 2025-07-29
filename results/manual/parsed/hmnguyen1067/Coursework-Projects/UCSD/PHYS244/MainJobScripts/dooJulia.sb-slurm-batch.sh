#!/bin/bash
#SBATCH --job-name=dooJL
#SBATCH --account=csd453
#SBATCH --output=dooJL.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=03:00:00
#SBATCH --partition=shared
#SBATCH --constraint=ntasks-per-node=1

export JULIA_NUM_THREADS='16'

module purge
module load slurm
module load cpu
module load gcc
module load julia
module load intel-mkl
export JULIA_NUM_THREADS=16
srun hostname -s > hostfile
sleep 5
julia --machine-file ./hostfile ./dooFinalJL.jl
