#!/bin/bash
#SBATCH --job-name=elsa-intro
#SBATCH --account=ec30
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=03:30:00
#SBATCH --partition=accel

set -o errexit  # Recommended for easier debugging
source /etc/profile
module purge
module load git-lfs/3.0.2
module load PyTorch/1.9.0-fosscuda-2020b
python -m venv ~/venvs/transformers --clear
source ~/venvs/transformers/bin/activate
pip install -r requirements.txt
DIR=configs/elsa/*
for f in $DIR
do
    python sq_label_elsa.py $f # run_sq_label.py $f
done
