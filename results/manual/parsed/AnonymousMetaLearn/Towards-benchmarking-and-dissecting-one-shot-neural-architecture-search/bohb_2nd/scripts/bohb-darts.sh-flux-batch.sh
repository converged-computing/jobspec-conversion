#!/bin/bash
#FLUX: --job-name=tart-diablo-9640
#FLUX: --priority=16

source activate tensorflow-stable
python src/darts_master.py --array_id $SLURM_ARRAY_TASK_ID --total_num_workers 16 --num_iterations 64 --run_id $SLURM_ARRAY_JOB_ID --working_directory ./bohb_output/ --min_budget 25 --max_budget 100 --seed 1 --space $1
