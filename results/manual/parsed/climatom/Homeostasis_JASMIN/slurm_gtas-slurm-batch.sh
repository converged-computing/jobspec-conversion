#!/bin/bash
#SBATCH --job-name=gtas_home
#SBATCH --output=%j_gtas.out
#SBATCH --error=%j_gtas.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=short-serial
#SBATCH --array=1-35

module add jaspy
cd /home/users/tommatthews/Homeostasis/
bash glob_mean.sh ${SLURM_ARRAY_TASK_ID}
