#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=1024M
#SBATCH --time=00:20:00

module load cuda/12.1
source /home/davide.cavicchini/.bashrc
conda activate SIV_hpe
python3 memo/main.py
