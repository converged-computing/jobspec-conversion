#!/bin/bash
#SBATCH --job-name=EPMC
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=02:55:00
#SBATCH --partition=scavenge
#SBATCH: --exclusive

echo "I ran on:"
cd $SLURM_SUBMIT_DIR
echo $SLURM_NODELIST
grep MemTotal /proc/meminfo
lspci
module load MATLAB/2020a
matlab -nodisplay -r "main_epmc($X); quit"
