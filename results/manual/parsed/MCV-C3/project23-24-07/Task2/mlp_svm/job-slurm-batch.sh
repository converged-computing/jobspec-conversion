#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=2000

SAVE_DIR=$1
sleep 1
python mlp_and_svm.py $SAVE_DIR $2
