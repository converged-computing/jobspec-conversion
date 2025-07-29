#!/bin/bash
#SBATCH --job-name=python-gpu
#SBATCH --output=/scratch/%u/Project/outputs/%x-%N-%j.out
#SBATCH --error=/scratch/%u/Project/errors/%x-%N-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:3g.40gb:1
#SBATCH --mem=4000M
#SBATCH --time=04:00:00
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=4

export PYTHONPATH='$(pwd):$PYTHONPATH'

set -x
umask 0027
cd /scratch/apathak2/Project
export PYTHONPATH=$(pwd):$PYTHONPATH
nvidia-smi
module load gnu10                           
module load python
python src/main.py
