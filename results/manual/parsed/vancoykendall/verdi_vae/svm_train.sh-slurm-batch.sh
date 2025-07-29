#!/bin/bash
#SBATCH --output=job_logs/svm_train.sh.log-%j-%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --array=1-6

echo test1
module load anaconda/2020b
echo test2
echo test3
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT
python svm_models.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
