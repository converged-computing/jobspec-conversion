#!/bin/bash
#SBATCH --job-name=reddit
#SBATCH --output=./../../datum/reddit/output/slurm/slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=01:00:00
#SBATCH --array=1-15

echo "now processing task id:: " ${SLURM_ARRAY_TASK_ID}
python3 run.py --job_array_task_id=${SLURM_ARRAY_TASK_ID} --run_version_number=8 --toy=False --dim_reduction=False --run_modelN=1
echo 'Finished.'
