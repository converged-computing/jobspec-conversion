#!/bin/bash
#SBATCH --job-name=genrd
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

cd $SLURM_SUBMIT_DIR
cmd=`sed -n "${SLURM_ARRAY_TASK_ID}p" genrdunmin`
eval $cmd
