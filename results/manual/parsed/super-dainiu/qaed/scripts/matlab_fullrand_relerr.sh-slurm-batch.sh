#!/bin/bash
#SBATCH --job-name=fullrand_cpu
#SBATCH --output=fullrand_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=20G
#SBATCH --time=1-00:00:00
#SBATCH --partition=day

module purge
module load MATLAB/2023a
matlab -nodisplay -nosplash -nodesktop -r "run('/home/ys792/project/qaed/test_relerr_fullrand.m');exit;"
