#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --qos=gpulab02
#SBATCH --constraint=ntasks-per-node=6

nvidia-smi
python3 script_predict.py --datadir ../datasets/testimgs/ --num_gpu 1 --losstype segment
