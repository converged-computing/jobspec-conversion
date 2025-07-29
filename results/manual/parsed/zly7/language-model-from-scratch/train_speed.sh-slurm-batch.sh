#!/bin/bash
#SBATCH --job-name=zly
#SBATCH --output=job.%j-speed.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --partition=gpulab02
#SBATCH --qos=gpulab02
#SBATCH --constraint=ntasks-per-node=12
#SBATCH --nodelist=gpu030

nvidia-smi
accelerate launch --config_file acce_config_1GPU.yaml --main_process_port 29501 train_vanilla_bert.py
accelerate launch --config_file acce_config_1GPU.yaml --main_process_port 29501 train_cos_bert.py
accelerate launch --config_file acce_config_1GPU.yaml --main_process_port 29501 train_directmul_bert.py
