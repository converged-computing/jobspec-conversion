#!/bin/bash
#SBATCH --job-name=optuna2
#SBATCH --output=./out/array_%A_%a.out
#SBATCH --error=./err/array_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=32G
#SBATCH --time=7-00:00:00
#SBATCH --partition=gpu
#SBATCH --array=0-9

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
nvidia-smi
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh
conda activate py39
A=(optuna2-{a..z})
python3 ../optuna_pelican_classifier.py --datadir=../data/v0 --cuda --nobj=126 --num-epoch=80 --batch-size=40 --num-train=6000 --num-valid=40000 --no-summarize --lr-decay-type=warm --no-textlog --no-predict --prefix="${A[$SLURM_ARRAY_TASK_ID]}" --sampler=random --pruner=hyperband --storage remote --host worker1031 --port 35719 --study-name=optuna2 --optuna-test
