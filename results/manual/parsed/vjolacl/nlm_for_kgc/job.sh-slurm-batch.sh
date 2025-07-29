#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=90000mb
#SBATCH --time=06:00:00

export PATH='/opt/intel/intelpython3/bin:$PATH'

export PATH="/opt/intel/intelpython3/bin:$PATH"
cd /pfs/data5/home/kit/aifb/ho8030/
nvidia-smi
source activate testenv
which python3
wandb login 5412702c3ad751442cbd9ac96d56a4ccbca97f1e
python3 04_py_files/run_kg_nlm.py
