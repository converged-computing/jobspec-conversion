#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=2

MAX_SEED=$1
CATEGORY=$2
CONTAMINATION=$3
module load Julia/1.5.1-linux-x86_64
module load Python/3.8.2-GCCcore-9.3.0
julia ./knn.jl ${MAX_SEED} $CATEGORY $CONTAMINATION
