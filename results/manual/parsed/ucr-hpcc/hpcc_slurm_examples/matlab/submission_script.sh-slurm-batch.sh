#!/bin/bash
#SBATCH --job-name=just_a_test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=02:00:00
#SBATCH --partition=short

module load matlab
matlab -nodisplay -nodesktop < my_matlab_program.m
