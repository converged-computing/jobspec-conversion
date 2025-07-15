#!/bin/bash
#FLUX: --job-name=ser
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate ser
let "min_seed = 14"
let "max_seed = 15"
echo "Running train.py with min_seed = $min_seed and max_seed = $max_seed"
python train.py --experiment_file experiments/run.json --low_seed "$min_seed" --high_seed "$max_seed"
