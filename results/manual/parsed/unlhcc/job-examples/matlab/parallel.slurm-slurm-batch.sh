#!/bin/bash
#SBATCH --job-name=invertRandArray
#SBATCH --output=parallel.%J.out
#SBATCH --error=parallel.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=4

module load matlab/r2020a
mkdir -p /tmp/$SLURM_JOB_ID
matlab -nodisplay -r "invertRand('10^4'), quit"
