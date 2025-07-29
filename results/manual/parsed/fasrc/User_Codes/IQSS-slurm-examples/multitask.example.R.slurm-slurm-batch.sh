#!/bin/bash
#SBATCH --job-name=multitask.example
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:15:00
#SBATCH --partition=serial_requeue

module purge > /dev/null 2>&1
module load gcc/7.1.0-fasrc01 R/3.5.0-fasrc01
module load intel/17.0.4-fasrc01 R/3.5.0-fasrc01
chmod u+x multitask.example.R 
./multitask.example.R "${SLURM_ARRAY_TASK_ID}"   # Run R hello world.
