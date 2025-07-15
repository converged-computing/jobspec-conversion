#!/bin/bash
#FLUX: --job-name=angry-salad-6640
#FLUX: --queue=gpu
#FLUX: -t=11700
#FLUX: --urgency=16

module purge
module load gcc/11.3.0
module load python
eval "$(conda shell.bash hook)"
deactivate
source csci467/bin/activate
python3 bert_baseline_lime_args.py --input=input/input_${SLURM_ARRAY_TASK_ID}
