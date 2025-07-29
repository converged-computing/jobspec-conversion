#!/bin/bash
#SBATCH --output=slurm-cpu-%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=00:10:00

date
echo "Slurm nodes: $SLURM_JOB_NODELIST"
echo
echo "${1}"
echo
${1}
echo
echo "Ending script..."
date
