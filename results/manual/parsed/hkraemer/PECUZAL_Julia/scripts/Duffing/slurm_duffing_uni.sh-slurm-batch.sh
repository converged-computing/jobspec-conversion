#!/bin/bash
#SBATCH --job-name=duf_u
#SBATCH --account=synet
#SBATCH --output=name-%j.out
#SBATCH --error=name-%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=standard
#SBATCH --qos=medium
#SBATCH --constraint=ntasks-per-node=8

module load julia/1.5.3
module load hpc
julia comm_duffing_ensemble_uni.jl
