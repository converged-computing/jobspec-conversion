#!/bin/bash
#SBATCH --job-name=AlexNetVanilla
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=8000
#SBATCH --time=2-03:00:00

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
source venv/bin/activate
pip freeze
python run_flow.py
