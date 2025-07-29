#!/bin/bash
#SBATCH --job-name=traindwnscale
#SBATCH --output=%A_%a.out
#SBATCH --error=%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=1-00:00:00
#SBATCH --partition=short-serial
#SBATCH --array=0-5

source /home/users/doran/software/envs/pytorch/bin/activate
python ../train_script2.py ${SLURM_ARRAY_TASK_ID}
