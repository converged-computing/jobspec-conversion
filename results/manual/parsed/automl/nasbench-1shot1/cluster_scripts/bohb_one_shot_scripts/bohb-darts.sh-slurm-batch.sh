#!/bin/bash
#SBATCH --output=./experiments/bohb_logs/logs/%A-%a.o
#SBATCH --error=./experiments/bohb_logs/logs/%A-%a.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --chdir=.
#SBATCH --array=1-16

source activate tensorflow-stable
python optimizers/bohb_one_shot/master.py --array_id $SLURM_ARRAY_TASK_ID --total_num_workers 16 --num_iterations 64 --run_id $SLURM_ARRAY_JOB_ID --working_directory ./experiments/bohb_output/cs$3 --min_budget 25 --max_budget 100 --space $1 --algorithm $2 --cs $3 --seed $4
