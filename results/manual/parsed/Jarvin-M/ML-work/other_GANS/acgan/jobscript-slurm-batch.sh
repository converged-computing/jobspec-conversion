#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4GB
#SBATCH --time=05:00:00

ml TensorFlow/1.10.1-fosscuda-2018a-Python-3.6.4
python -u acgan64.py
