#!/bin/bash
#SBATCH --job-name=lstm_training
#SBATCH --output=.lstm.out
#SBATCH --error=.lstm.err
#SBATCH --mail-user=francesco.campi@helmholtz-munich.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=4-00:00:00
#SBATCH --partition=gpu_p
#SBATCH --qos=gpu_long

CUDA_VISIBLE_DEVICES=0
python oligo_designer_toolsuite_ai_filters/hybridization_probability/train_model.py -c configs/hybridization_probability/train_LSTM.yaml  
