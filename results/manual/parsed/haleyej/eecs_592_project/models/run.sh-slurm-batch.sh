#!/bin/bash
#SBATCH --job-name=demo
#SBATCH --account=eecs592s001w24_class
#SBATCH --output=/home/apalakod/eecs_592_project/Bert_training.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=180g
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1

/bin/hostname
nvidia-smi
python3 /home/apalakod/eecs_592_project/models/climate_denial_downstream.py --pretrained_model_path='/home/apalakod/eecs_592_project/zip_gg_files/fine-tuned_models/base' --model_name='base' --data_path='/home/apalakod/eecs_592_project/data/climate_sentiment_train.csv' --test_data_path='/home/apalakod/eecs_592_project/data/climate_sentiment_test.csv' --mode='test-base'
