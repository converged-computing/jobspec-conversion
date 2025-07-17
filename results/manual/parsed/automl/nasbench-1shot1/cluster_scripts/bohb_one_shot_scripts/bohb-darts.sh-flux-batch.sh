#!/bin/bash
#FLUX: --job-name=confused-pot-4642
#FLUX: --queue=bosch_gpu-rtx2080
#FLUX: --urgency=16

source activate tensorflow-stable
python optimizers/bohb_one_shot/master.py --array_id $SLURM_ARRAY_TASK_ID --total_num_workers 16 --num_iterations 64 --run_id $SLURM_ARRAY_JOB_ID --working_directory ./experiments/bohb_output/cs$3 --min_budget 25 --max_budget 100 --space $1 --algorithm $2 --cs $3 --seed $4
