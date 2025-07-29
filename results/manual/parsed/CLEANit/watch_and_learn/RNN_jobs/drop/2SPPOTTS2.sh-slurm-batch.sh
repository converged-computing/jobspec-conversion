#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00

source activate tensorflow
module load cudnn/7.0-9.0
python RNN_MODELS.py drop/2SP SPIRAL POTTS1 DSIZE=512 RUNS=0 EPOCHS=15 keep_prob=0.9
