#!/bin/bash
#SBATCH --job-name=surf.discoal
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120gb
#SBATCH --time=12:00:00
#SBATCH --partition=astyanax,small,amdsmall,cavefish
#SBATCH --array=1-23

cd /home/mcgaughs/shared/Software/diploSHIC
discoal="/home/mcgaughs/shared/Software/discoal/discoal"
CMD_LIST="Surface_discoal_commands_w_3popsizes_2.txt"
CMD="$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${CMD_LIST})"
eval ${CMD}
