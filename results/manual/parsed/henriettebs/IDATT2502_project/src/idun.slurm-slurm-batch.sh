#!/bin/bash
#SBATCH --job-name=Stock prediction training
#SBATCH --account=ie-idi
#SBATCH --output=prediction-srun.out
#SBATCH --mail-user=hannagn@stud.ntnu.no
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --gres=gpu:1
#SBATCH --mem=12000
#SBATCH --time=04:00:00

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
module load Python/3.10.4-GCCcore-11.3.0
pip install numpy
pip install torch
pip install yahoo_fin
pip install tensorflow
pip install scikit_learn
pip install keras
pip install matplotlib
pip install pandas
pip install statsmodels
pip install yfinance
python3 src/main.py
