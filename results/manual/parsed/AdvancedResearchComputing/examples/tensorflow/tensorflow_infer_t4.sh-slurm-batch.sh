#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

module reset
module load TensorFlow
echo "TENSORFLOW_INFER_T4: Normal beginning of execution."
python beginner.py
echo "TENSORFLOW_INFER_T4: Normal end of execution."
