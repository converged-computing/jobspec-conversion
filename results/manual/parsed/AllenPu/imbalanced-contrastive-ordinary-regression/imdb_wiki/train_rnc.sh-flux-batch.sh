#!/bin/bash
#FLUX: --job-name=baselines
#FLUX: -c=6
#FLUX: -t=345600
#FLUX: --urgency=16

module load StdEnv/2020 cuda scipy-stack python/3.8
source /home/ruizhipu/envs/py38/bin/activate
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
python train_rnc.py --lr 0.01  --groups 10 --aug group --epoch 400 --data_dir /home/ruizhipu/scratch/regression/imbalanced-regression/imdb-wiki-dir/data
