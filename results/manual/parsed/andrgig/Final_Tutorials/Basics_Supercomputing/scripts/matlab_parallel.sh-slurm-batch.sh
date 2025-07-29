#!/bin/bash
#SBATCH --job-name=Matlab_parallel
#SBATCH --output=Matlab_parallel.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:03:00

ml matlab
matlab -nodisplay -nodesktop -r "clear; num_workers=12; matlab_parallel;"
