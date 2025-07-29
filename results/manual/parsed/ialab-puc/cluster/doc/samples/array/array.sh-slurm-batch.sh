#!/bin/bash
#SBATCH --job-name=average_random
#SBATCH --output=results/array_%A-%a.log
#SBATCH --mail-user=usuario@uc.cl
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=00:05:00
#SBATCH --array=1-100%10

python3 /user/slurm/samples/array/average.py $SLURM_ARRAY_TASK_ID
