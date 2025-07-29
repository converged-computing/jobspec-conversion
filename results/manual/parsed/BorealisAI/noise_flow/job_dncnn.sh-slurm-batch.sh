#!/bin/bash
#SBATCH --job-name=dncnn_nf
#SBATCH --output=logs/job_output_%j.out
#SBATCH --error=logs/job_error_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=40G

hostname
whoami
python train_dncnn_noiseflow.py \
        --model DnCNN_Gauss \
        --train_data '/home/abdo/Downloads/SIDD_Medium_Raw/Data' \
        --save_every 20 \
        --max_epoch 2000 \
        --num_gpus 1
