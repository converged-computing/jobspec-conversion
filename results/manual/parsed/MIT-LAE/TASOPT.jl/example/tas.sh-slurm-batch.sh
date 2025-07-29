#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4000M
#SBATCH --time=00:05:00
#SBATCH --partition=normal

julia --project=../. $1
oom_check $?
