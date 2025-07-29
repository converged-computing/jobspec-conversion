#!/bin/bash
#SBATCH --job-name=bohb-darts-2nd
#SBATCH --output=./logs/%A-%a.o
#SBATCH --error=./logs/%A-%a.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=bosch_gpu-rtx2080
#SBATCH --chdir=.
#SBATCH --array=1-16

source activate tensorflow-stable
python src/darts_master.py --array_id $SLURM_ARRAY_TASK_ID --total_num_workers 16 --num_iterations 64 --run_id $SLURM_ARRAY_JOB_ID --working_directory ./bohb_output/ --min_budget 25 --max_budget 100 --seed 1 --space $1
