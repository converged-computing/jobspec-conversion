#!/bin/bash
#FLUX: --job-name=nn_boulder # Note that %A and %a are the place holders for job id and array id
#FLUX: --priority=16

export GHZHANG17_TASK_ID='$SLURM_ARRAY_TASK_ID'
export GHZHANG17_JOB_ID='$SLURM_JOB_ID'

export GHZHANG17_TASK_ID=$SLURM_ARRAY_TASK_ID
export GHZHANG17_JOB_ID=$SLURM_JOB_ID
echo "Task ID:" $GHZHANG17_TASK_ID
echo "Job ID:" $GHZHANG17_JOB_ID
module load python/3.6.3-fasrc01
module load Anaconda3/5.0.1-fasrc02
source activate comet
python nn_sgd.py --it_ind 0 --inputSize 100 --outputSize 100 --hiddenSize $GHZHANG17_TASK_ID --learningRate 5 --epochs 100000
