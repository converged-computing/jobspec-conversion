#!/bin/bash
#SBATCH --job-name=ctime
#SBATCH --output=/home/livingstonb/GitHub/Continuous_Time_HA/output/run%a.out
#SBATCH --error=/home/livingstonb/GitHub/Continuous_Time_HA/output/run%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6000
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-156

module load matlab/2019b
matlab -nodisplay < /home/livingstonb/GitHub/Continuous_Time_HA/master.m
