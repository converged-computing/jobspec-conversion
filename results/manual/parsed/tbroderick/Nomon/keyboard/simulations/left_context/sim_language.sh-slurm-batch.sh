#!/bin/bash
#SBATCH --output=sim_param_opt.out-%j-%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=1-4

source /etc/profile
module load anaconda3-5.0.1
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT
python3 language.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
