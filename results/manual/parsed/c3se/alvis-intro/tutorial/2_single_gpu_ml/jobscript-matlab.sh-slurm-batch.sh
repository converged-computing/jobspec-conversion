#!/bin/bash
#SBATCH --job-name=ml-matlab
#SBATCH --account=NAISS2024-22-219
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00

ml purge
ml MATLAB
echo "Running MATLAB from $HOSTNAME"
matlab -batch regression
