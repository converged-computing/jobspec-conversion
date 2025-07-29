#!/bin/bash
#SBATCH --job-name=metaheuristic
#SBATCH --output=/home/jarredondo/projects/QAP/logs/pipes/%a_%A.txt
#SBATCH --error=/home/jarredondo/projects/QAP/logs/pipes/%a_%A.err
#SBATCH --mail-user=javier.arredondo.c@usach.cl
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=general
#SBATCH --array=1-101%101

ml R/4.0.0
heuristic='SA'
file='esc64a.txt'
workdir='/home/jarredondo/projects/QAP/'
Rscript --vanilla main.R $file 'SA' ${SLURM_ARRAY_TASK_ID} $workdir
