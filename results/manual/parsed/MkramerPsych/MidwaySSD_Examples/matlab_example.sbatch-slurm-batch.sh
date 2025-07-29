#!/bin/bash
#SBATCH --job-name=MATLAB_ex
#SBATCH --account=ssd
#SBATCH --output=MAT_ex.out
#SBATCH --error=MAT_ex.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=00:05:00
#SBATCH --partition=ssd
#SBATCH --constraint=ntasks-per-node=4

module load matlab
matlab -nodisplay < MATLAB_example.m
