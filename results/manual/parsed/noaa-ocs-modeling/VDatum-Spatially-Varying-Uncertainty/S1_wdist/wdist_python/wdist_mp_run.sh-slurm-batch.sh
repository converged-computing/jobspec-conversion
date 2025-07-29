#!/bin/bash
#SBATCH --job-name=HPL
#SBATCH --account=vdatum
#SBATCH --output=station-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000M
#SBATCH --time=03:00:00
#SBATCH --qos=batch
#SBATCH --chdir=.
#SBATCH --array=0-9

date
echo "host name is `hostname` : $SLURM_ARRAY_TASK_ID gages_ids_nodes.txt fort.14"
cp   ../TXstabilize/fort.14 tt/${SLURM_ARRAY_TASK_ID}.fort.14
cp   gages_ids_nodes.txt tt/${SLURM_ARRAY_TASK_ID}.gages.txt
./wdist.py $SLURM_ARRAY_TASK_ID tt/${SLURM_ARRAY_TASK_ID}.gages.txt tt/${SLURM_ARRAY_TASK_ID}.fort.14
date
