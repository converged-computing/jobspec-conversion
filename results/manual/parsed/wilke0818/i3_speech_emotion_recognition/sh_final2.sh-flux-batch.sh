#!/bin/bash
#FLUX: --job-name=ser
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate ser
let "min_seed = ($SLURM_ARRAY_TASK_ID - 1) * 10"
let "max_seed = ($SLURM_ARRAY_TASK_ID) * 10"
echo "Running run.py with min_seed = $min_seed and max_seed = $max_seed"
python run.py --experiment_file experiments_final/run.json --low_seed "$min_seed" --high_seed "$max_seed"
