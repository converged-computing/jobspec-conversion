#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --partition=a100_dev_q
#SBATCH --constraint=ntasks-per-node=1

module reset
module load cuda11.2/toolkit #hopefully will be added to defaults soon
module load TensorFlow
echo "TENSORFLOW_TINKERCLIFFS_A100: Normal beginning of execution."
python beginner.py
echo "TENSORFLOW_TINKERCLIFFS_A100: Normal end of execution."
