#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=C:/Users/thiba/OneDrive/Bureau/emg1

slmodules -s x86_E5v2_Mellanox_GPU
module load gcc cuda cudnn mvapich2 openblas
source venvs/venvs/emg_tn/bin/activate
srun python emg1.py
