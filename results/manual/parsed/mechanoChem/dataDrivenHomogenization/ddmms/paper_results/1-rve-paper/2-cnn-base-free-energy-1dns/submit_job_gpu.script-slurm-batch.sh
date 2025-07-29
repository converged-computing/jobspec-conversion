#!/bin/bash
#SBATCH --job-name=zxx_gpu1
#SBATCH --mail-user=xxzh@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=25GB
#SBATCH --time=1-23:00:00
#SBATCH --partition=gpu-shared
#SBATCH --constraint=ntasks-per-node=6

export PYTHONPATH='PYTHONPATH:$HOME/python_projects/'

hostname
root=/home/xxzh/auto_test/mylib
export PYTHONPATH=PYTHONPATH:$HOME/python_projects/
module purge
module load cuda/9.2
conda init
conda activate tf-gpu
nvcc --version
timeout 2 nvidia-smi
python hyper_parameter_search.py
