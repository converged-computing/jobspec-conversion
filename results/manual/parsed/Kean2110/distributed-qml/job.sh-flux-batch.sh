#!/bin/bash
#FLUX: --job-name=dqml
#FLUX: --queue=All
#FLUX: --urgency=16

echo Running on node $SLURMD_NODENAME at `date`
. ./env/bin/activate
cd two_feature_app
python main.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_JOB_ID$SLURM_ARRAY_TASK_ID
echo Finished at `date`
