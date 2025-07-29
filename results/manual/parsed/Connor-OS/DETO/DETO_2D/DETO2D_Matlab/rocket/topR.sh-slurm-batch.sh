#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --time=00:05:00

export MCR_CACHE_ROOT='$TMPDIR'

module load MATLAB
matlab -nodisplay -nosplash < topR.m
export MCR_CACHE_ROOT=$TMPDIR
