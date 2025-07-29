#!/bin/bash
#SBATCH --job-name=vgg_afd
#SBATCH --output=./output/train/%A_%a.out
#SBATCH --mail-user=kdobs@mit.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:QUADRORTX6000:1
#SBATCH --mem=12G
#SBATCH --time=6-23:00:00

CONFIG_FILE='./configs/vgg/face_AFD_matched_seed.yaml'
SCRIPT=./train_new.py
hostname
date
echo "Sourcing conda..."
source /mindhive/nklab4/users/kdobs/anaconda3/bin/activate
date
echo "Activating conda env..."
conda activate torch-gpu-dev
date
echo "Running python script..."
CUDA_VISIBLE_DEVICES=0 python $SCRIPT --config_file $CONFIG_FILE --num_epochs 201 --read_seed 1 --maxout True --save_freq 10 --valid_freq 1 --use_scheduler "True" --pretrained "False" # --custom_learning_rate 0.0001
date
echo "Job completed"
