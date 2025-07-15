#!/bin/bash
#FLUX: --job-name=array-job
#FLUX: --queue=caslake
#FLUX: -t=126000
#FLUX: --urgency=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module load python
module load pytorch
cd $SCRATCH/$USER/CCA
echo $1
echo $2
python3 experiments/experiment.py --model $1 --epochs 2000 --patience 3 --dataset $2 --lr $3 --normalize $4 --result_file $SLURM_ARRAY_TASK_ID
~
~
