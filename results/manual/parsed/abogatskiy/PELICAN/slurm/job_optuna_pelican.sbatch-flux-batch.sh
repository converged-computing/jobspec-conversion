#!/bin/bash
#FLUX: --job-name=optuna
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
nvidia-smi
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh
conda activate py39
A=(optuna-{a..z})
python3 ../optuna_pelican_cov.py --datadir=../data/btW_1_d --target=truth_Pmu_2 --cuda --nobj=48 --nobj-avg=21 --num-epoch=35 --batch-size=128 --num-train=100000 --num-valid=60000 --num-test=100000 --no-summarize --lr-decay-type=cos --no-textlog --no-predict --prefix="${A[$SLURM_ARRAY_TASK_ID]}" --sampler=tpe --pruner=median --storage remote --host worker1026 --port 35719 --study-name=btW1_0 --optuna-test
