#!/bin/bash
#SBATCH --job-name=JULIA
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:01:00
#SBATCH --constraint=ntasks-per-node=1,op

cd $SLURM_SUBMIT_DIR
module load julia
julia example.jl > result
