#!/bin/bash
#SBATCH --job-name=arrayjob
#SBATCH --output=arrayjob-%a.out
#SBATCH --error=arrayjob-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --array=1-4

echo "Running job array number: "$SLURM_ARRAY_TASK_ID
module load matlab/R2016a
matlab-threaded -nodisplay -nojvm -r "foo($SLURM_ARRAY_TASK_ID), exit"
