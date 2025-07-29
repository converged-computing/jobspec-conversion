#!/bin/bash
#SBATCH --job-name=lstm
#SBATCH --output=lstm_res_%j.txt
#SBATCH --error=lstm_res_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-01:00:00

source /home/rgangaraju/.bashrc
source activate tf
hostname
python -u /home/rgangaraju/lstm/generic_lstm.py
sleep 1
exit
