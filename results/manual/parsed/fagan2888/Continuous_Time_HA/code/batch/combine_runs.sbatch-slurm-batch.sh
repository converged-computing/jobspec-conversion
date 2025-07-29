#!/bin/bash
#SBATCH --job-name=combine2a
#SBATCH --output=/home/livingstonb/GitHub/Continuous_Time_HA/output/combine.out
#SBATCH --error=/home/livingstonb/GitHub/Continuous_Time_HA/output/combine.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=00:20:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1

module load matlab/2019b
matlab -nodisplay < /home/livingstonb/GitHub/Continuous_Time_HA/code/batch/combine_runs.m
