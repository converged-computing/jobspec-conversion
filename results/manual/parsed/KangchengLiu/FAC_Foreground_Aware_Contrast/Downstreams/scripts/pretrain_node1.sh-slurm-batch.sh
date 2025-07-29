#!/bin/bash
#SBATCH --job-name=FAC
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=80
#SBATCH --gres=gpu:8
#SBATCH --mem=400G
#SBATCH --time=3-00:00:00
#SBATCH --partition=dev
#SBATCH --constraint=volta32gb

export PYTHONPATH='$PWD:$PYTHONPATH'

EXPERIMENT_PATH="./checkpoints/testlog"
mkdir -p $EXPERIMENT_PATH
export PYTHONPATH=$PWD:$PYTHONPATH
srun --output=${EXPERIMENT_PATH}/%j.out --error=${EXPERIMENT_PATH}/%j.err --label python scripts/singlenode-wrapper.py main.py $1
