#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH --partition=cpufast
#SBATCH --constraint=ntasks-per-node=2

MAX_SEED=$1
DATASET=$2
CONTAMINATION=$3
module load Python/3.8
module load Julia/1.7.3-linux-x86_64
julia --project ./MGMM.jl ${MAX_SEED} $DATASET $CONTAMINATION
