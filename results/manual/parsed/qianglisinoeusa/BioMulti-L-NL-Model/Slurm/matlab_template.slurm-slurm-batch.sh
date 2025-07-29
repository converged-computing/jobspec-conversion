#!/bin/bash
#SBATCH --job-name=model_C1
#SBATCH --output=model_C1_out.out
#SBATCH --error=model_C1_err.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --gres=gpu:0
#SBATCH --mem=256M
#SBATCH --time=4-04:39:00

module load MATLAB/R2016a
matlab -nodisplay < systematic_connectivity.m
