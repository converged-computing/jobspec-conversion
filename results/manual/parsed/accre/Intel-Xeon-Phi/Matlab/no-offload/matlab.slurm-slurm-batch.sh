#!/bin/bash
#SBATCH --output=vanilla.out
#SBATCH --mail-user=vunetid@vanderbilt.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00

setpkgs -a matlab
matlab -nodisplay -nosplash < matrix.m
