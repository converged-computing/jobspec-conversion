#!/bin/bash
#SBATCH --account=bdlds01
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

module load cuda
module load Anaconda3
nvidia-smi
source activate wmlce_env
python model/main.py
