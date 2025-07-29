#!/bin/bash
#SBATCH --job-name=UCR_Heartbeat
#SBATCH --output=auto_script/output_log/UCR_Heartbeat.out
#SBATCH --error=auto_script/output_log/UCR_Heartbeat.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00

module purge
module load pytorch-gpu/py3/1.7.0
set -x
python -u script_exp_dataset.py ../../../data/UCR_UEA/Heartbeat.pickle 1000 3 8 0.8
