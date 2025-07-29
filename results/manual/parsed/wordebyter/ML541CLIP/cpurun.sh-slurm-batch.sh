#!/bin/bash
#SBATCH --job-name=ML541-final
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=30g
#SBATCH --time=12:00:00
#SBATCH --constraint=EPYC-7543&(A100|V100)

module load python/3.12.3/mftt2ua
module load cuda11.7/toolkit/11.7.1
python -m venv env
source env/bin/activate
pip install -r requirements.txt
python3 data_argument.py
