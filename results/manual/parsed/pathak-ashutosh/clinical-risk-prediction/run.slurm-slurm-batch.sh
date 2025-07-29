#!/bin/bash
#SBATCH --job-name=python-gpu
#SBATCH --output=/scratch/%u/Clinical Risk Prediction/outputs/%x-%N-%j.out
#SBATCH --error=/scratch/%u/Clinical Risk Prediction/errors/%x-%N-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100.80gb:1
#SBATCH --mem=8000M
#SBATCH --time=00:10:00
#SBATCH --partition=gpuq
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=4

export PYTHONPATH='$(pwd):$PYTHONPATH'

set -x
umask 0027
cd "/scratch/apathak2/Clinical Risk Prediction"
export PYTHONPATH=$(pwd):$PYTHONPATH
nvidia-smi
module load gnu10                           
module load python
python src/main.py
