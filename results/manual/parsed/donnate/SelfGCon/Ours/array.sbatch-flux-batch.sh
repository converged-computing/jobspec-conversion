#!/bin/bash
#FLUX: --job-name=array-job
#FLUX: --queue=caslake
#FLUX: -t=126000
#FLUX: --priority=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module load python
module load pytorch 
cd $SCRATCH/$USER/SelfGCon
echo $1
echo $2
python3 Ours/hyperparameter.py --result_file $SLURM_ARRAY_TASK_ID
~
~
