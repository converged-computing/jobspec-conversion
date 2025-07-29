#!/bin/bash
#SBATCH --job-name=project_ia
#SBATCH --mail-user=Chris.Adam@ulb.be
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=2625
#SBATCH --time=1-00:00:00

module load TensorFlow/2.3.1-fosscuda-2019b-Python-3.7.4
python3 main.py
