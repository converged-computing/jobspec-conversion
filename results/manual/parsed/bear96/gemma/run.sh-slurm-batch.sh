#!/bin/bash
#SBATCH --job-name=run-function
#SBATCH --account=thermaltext
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

module load Python/3.11.3-GCCcore-12.3.0
python3 --version
nvidia-smi
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
python main.py
