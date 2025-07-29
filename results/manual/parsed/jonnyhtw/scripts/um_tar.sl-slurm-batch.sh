#!/bin/bash
#SBATCH --job-name=um_tar
#SBATCH --account=niwa00013
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=1-00:00:00
#SBATCH --partition=nesi_prepost
#SBATCH --array=1950-2014

export suite='dc545'

export suite=dc545
cd /home/williamsjh/cylc-run/u-${suite}/runN/share/data/History_Data/
find . -maxdepth 1 -iname "*a.p${stream}${SLURM_ARRAY_TASK_ID}*" -exec tar --remove-files -rvf ${suite}a.p${stream}${SLURM_ARRAY_TASK_ID}.tar {} \; 
