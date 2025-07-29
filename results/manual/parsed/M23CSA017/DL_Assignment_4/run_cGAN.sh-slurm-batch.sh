#!/bin/bash
#SBATCH --job-name=testing
#SBATCH --output=first_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1

module load python/3.10.pytorch
python3 cGANS.py &> cGAN_run_wcgan_aux.txt &
nvidia-smi &
wait
