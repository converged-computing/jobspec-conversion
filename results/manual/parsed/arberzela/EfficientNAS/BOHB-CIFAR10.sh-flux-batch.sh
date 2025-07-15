#!/bin/bash
#FLUX: --job-name=strawberry-butter-7399
#FLUX: --priority=16

source activate pytorch
python cifar10_master.py --array_id $SLURM_ARRAY_TASK_ID --total_num_workers 10 --num_iterations 32 --run_id $SLURM_ARRAY_JOB_ID --working_directory ./data/run_$SLURM_ARRAY_JOB_ID
