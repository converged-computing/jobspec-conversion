#!/bin/bash
#SBATCH --output=slurm_logs/%j.out
#SBATCH --error=slurm_logs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

python main.py train_evaluate --config_file configs/resnet101_attention.yaml --outputpath experiments/best --schedule_sampling cycle --sample_k 5 --cudaid $1
