#!/bin/bash
#FLUX: --job-name=optuna2
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --priority=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
nvidia-smi
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh
conda activate py39
A=(optuna2-{a..z})
python3 ../optuna_pelican_classifier.py --datadir=../data/v0 --cuda --nobj=126 --num-epoch=80 --batch-size=40 --num-train=6000 --num-valid=40000 --no-summarize --lr-decay-type=warm --no-textlog --no-predict --prefix="${A[$SLURM_ARRAY_TASK_ID]}" --sampler=random --pruner=hyperband --storage remote --host worker1031 --port 35719 --study-name=optuna2 --optuna-test
