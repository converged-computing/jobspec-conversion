#!/bin/bash
#SBATCH --job-name=second
#SBATCH --output=second_%A.out
#SBATCH --error=second_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --time=1-12:00:00
#SBATCH --constraint=ib

module load matlab/2013b
mkdir -p /tmp/tintelnot/$SLURM_JOB_ID
matlab -nodisplay < Main_stat_counter2.m
rm -rf /tmp/tintelnot/$SLURM_JOB_ID
