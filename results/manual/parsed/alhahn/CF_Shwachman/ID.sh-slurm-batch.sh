#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=14-00:00:00
#SBATCH --partition=defq
#SBATCH --array=0-3

SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
myList=('14A'
'14C'
'21D'
'23A')
filename=${myList[${SLURM_ARRAY_TASK_ID}]}
pathoscope ID -alignFile results_"$filename"/"$filename".sam -fileType sam -outDir results_"$filename" -expTag "$filename"
$IFS=$SAVEIFS
