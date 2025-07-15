#!/bin/bash
#FLUX: --job-name=mlj-p
#FLUX: -t=172800
#FLUX: --priority=16

echo "this is subjob" $(($1*1000 + $SLURM_ARRAY_TASK_ID))""
date
cd ./symreg_methods_comparison/
singularity exec symreg.sif python3.7 ./src/proged_system_identification_fullobs.py $(($1*1000 + $SLURM_ARRAY_TASK_ID))
echo "completed" 
