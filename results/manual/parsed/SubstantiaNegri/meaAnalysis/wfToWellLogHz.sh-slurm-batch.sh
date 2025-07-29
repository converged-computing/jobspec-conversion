#!/bin/bash
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=48G
#SBATCH --time=00:15:00
#SBATCH --partition=priority

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
if [ "$1" != "" ]; then
    echo "Recording Duration provided as ${1} seconds"
else
    echo "Error: Need to provide Recording Duration as integer in seconds"
fi
srun ~/scripts/R-3.4.1/wfToWellLogHz.R $1
