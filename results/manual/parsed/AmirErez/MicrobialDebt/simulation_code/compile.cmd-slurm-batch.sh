#!/bin/bash
#SBATCH --output=logs/compile_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=18:00:00

export MCR_CACHE_ROOT='/tmp/$SLURM_JOB_ID'

module load matlab/2021a mcc
export MCR_CACHE_ROOT=/tmp/$SLURM_JOB_ID
mcc -mv automated_run_serialdil.m
