#!/bin/bash
#SBATCH --job-name=binaural
#SBATCH --output=binaural.txt
#SBATCH --error=error.txt
#SBATCH --mail-user=ghunkins@u.rochester.edu
#SBATCH --mail-type=begin
#SBATCH --nodes=25
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=125gb
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=2

source activate keras
python neuralnet.py
