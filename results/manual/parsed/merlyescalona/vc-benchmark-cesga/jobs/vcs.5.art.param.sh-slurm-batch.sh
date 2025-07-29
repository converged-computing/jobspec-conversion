#!/bin/bash
#SBATCH --job-name=art
#SBATCH --output=/mnt/lustre/scratch/home/uvi/be/mef/output/vcs.5.1.o
#SBATCH --error=/mnt/lustre/scratch/home/uvi/be/mef/error/vcs.5.1.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=shared
#SBATCH --qos=shared
#SBATCH --chdir=/mnt/lustre/scratch/home/uvi/be/mef/data/

echo -e "[$(date)]\nDefinition"
command=$(awk "NR==${SLURM_ARRAY_TASK_ID}" $1)
module load gcc/5.3.0 art/2016-06-05
echo $command
$command
module unload gcc/5.3.0 art/2016-06-05
