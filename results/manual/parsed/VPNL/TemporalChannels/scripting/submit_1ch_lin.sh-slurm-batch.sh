#!/bin/bash
#SBATCH --job-name=c1l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=2GB
#SBATCH --time=1-00:00:00

module load matlab/R2017a
matlab -nodisplay < optimize_1ch_lin.m
