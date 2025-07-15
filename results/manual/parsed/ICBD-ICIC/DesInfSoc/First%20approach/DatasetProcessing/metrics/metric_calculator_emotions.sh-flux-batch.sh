#!/bin/bash
#FLUX: --job-name=itrust-emotions
#FLUX: -t=432000
#FLUX: --priority=16

source .emotions_env/bin/activate
srun python metric_calculator_emotions.py ${SLURM_ARRAY_TASK_ID} 
