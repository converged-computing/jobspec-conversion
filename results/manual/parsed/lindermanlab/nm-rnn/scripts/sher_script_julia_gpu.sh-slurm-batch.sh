#!/bin/bash
#SBATCH --job-name=nmrnn
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=normal,hns,owners,swl1

ml python/3.9
source /home/groups/swl1/nm-rnn/.venv/bin/activate
wandb agent nm-rnn/nm-rnn-mwg/nmpc45l4
