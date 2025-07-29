#!/bin/bash
#SBATCH --output=./logs/%A-%a.o
#SBATCH --error=./logs/%A-%a.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=meta_gpu-ti
#SBATCH --chdir=.
#SBATCH --array=1-10

source activate pytorch
python cifar10_master.py --array_id $SLURM_ARRAY_TASK_ID --total_num_workers 10 --num_iterations 32 --run_id $SLURM_ARRAY_JOB_ID --working_directory ./data/run_$SLURM_ARRAY_JOB_ID
