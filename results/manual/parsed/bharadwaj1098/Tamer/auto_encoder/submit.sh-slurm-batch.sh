#!/bin/bash
#SBATCH --job-name=auto_encoder_type1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:TitanV:1
#SBATCH --mem=16G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=4

module load pytorch/1.6.0-anaconda3-cuda10.2
pip install --no-index --upgrade pip
conda install -c akode atari-py  
python Type_1.py
