#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=24G
#SBATCH --time=00:30:00

export LD_LIBRARY_PATH='/home/tysweat0/.conda/envs/img2img/lib/python3.9/site-packages/nvidia/cublas/lib'

export LD_LIBRARY_PATH=/home/tysweat0/.conda/envs/img2img/lib/python3.9/site-packages/nvidia/cublas/lib
cd ~/StableComics/FullPipeline/
nvidia-smi --list-gpus
nvidia-smi --query-gpu=memory.total --format=csv
python run.py
