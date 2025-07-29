#!/bin/bash
#SBATCH --job-name=baseline-torch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=32G
#SBATCH --time=02:45:00
#SBATCH --constraint=ntasks-per-node=1

source $STORE/mytorchdist/bin/deactivate
source $STORE/mytorchdist/bin/activate
which python
python BASELINE.py
