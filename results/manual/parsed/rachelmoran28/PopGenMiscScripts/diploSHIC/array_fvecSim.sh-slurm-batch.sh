#!/bin/bash
#SBATCH --job-name=fvecSim
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60gb
#SBATCH --time=03:00:00
#SBATCH --partition=small,amdsmall,astyanax
#SBATCH --array=1-23

cd /home/mcgaughs/shared/Software/diploSHIC
CMD_LIST="Surface.fvecSim.commnads.txt"                                                                                                                                                               
CMD="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${CMD_LIST})"
eval ${CMD}
