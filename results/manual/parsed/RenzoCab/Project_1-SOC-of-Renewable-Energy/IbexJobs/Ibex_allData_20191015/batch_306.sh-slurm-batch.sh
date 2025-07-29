#!/bin/bash
#SBATCH --job-name=renzoCaballero
#SBATCH --output=info.%J.out
#SBATCH --error=info.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60G
#SBATCH --time=2-02:00:00
#SBATCH --partition=batch
#SBATCH --constraint=ntasks-per-node=40,[intel]

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load matlab/R2018a
matlab -nodisplay < iterationsAndOptimization.m
