#!/bin/bash
#SBATCH --job-name=RUnet_comb
#SBATCH --output=%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:gtx1080:1
#SBATCH --time=00:40:00
#SBATCH --constraint=ntasks-per-node=2

cd $SLURM_SUBMIT_DIR
module load python/3.6.0
module load groupmods/me539/cuda
module list
python3 py_comb.py
