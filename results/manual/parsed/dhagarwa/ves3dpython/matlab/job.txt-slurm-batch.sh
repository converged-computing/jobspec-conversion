#!/bin/bash
#SBATCH --job-name=matlabjob
#SBATCH --output=jobresults/test%j.out
#SBATCH --error=jobresults/matlabjob.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00

module load matlab
matlab -nodesktop -nodisplay -nosplash < gputest.m
