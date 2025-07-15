#!/bin/bash
#FLUX: --job-name=fugly-signal-8726
#FLUX: --priority=16

echo $(tail -n+$SLURM_ARRAY_TASK_ID dst_exp_params.txt | head -n1)
cd ../scripts
python -u train_model.py $(tail -n+$SLURM_ARRAY_TASK_ID ../slurm_scripts/dst_exp_params.txt | head -n1)
