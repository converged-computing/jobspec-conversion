#!/bin/bash
#FLUX: --job-name=ANNRP_hparam_search
#FLUX: -t=72000
#FLUX: --urgency=16

pwd; hostname; date
module load tensorflow/2.4.1
module list
python --version
param_csv=$1
array_id=$SLURM_ARRAY_TASK_ID
offset=$2
index=$((SLURM_ARRAY_TASK_ID + offset))
python hparam_search_multi.py $param_csv $index
