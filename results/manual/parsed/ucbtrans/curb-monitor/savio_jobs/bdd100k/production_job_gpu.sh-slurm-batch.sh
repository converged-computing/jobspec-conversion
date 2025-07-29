#!/bin/bash
#SBATCH --job-name=pre-process-model-training-gpu-prod
#SBATCH --account=fc_control
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:GTX2080TI:1
#SBATCH --time=3-00:00:00

module load python gcc opencv cmake
pip install --user --upgrade pip setuptools wheel && pip install --user -r ~/curb-monitor/requirements.txt
cd ~/curb-monitor && python ./training/bdd100k/train.py
