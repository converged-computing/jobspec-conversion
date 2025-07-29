#!/bin/bash
#SBATCH --job-name=MyMATLABJob
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00
#SBATCH --partition=batch

t0=$(date +%s)
module load matlab/R2021a
matlab-threaded -nodesktop -nosplash -r "myfunction($SLURM_ARRAY_TASK_ID), exit"
t1=$(date +%s)
dt=$(echo "$t1 - $t0" | bc)
printf "Total execution time (s): %08.1f\n" $dt
