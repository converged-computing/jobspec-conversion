#!/bin/bash
#SBATCH --job-name=ntu60cv
#SBATCH --output=./logs/%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --constraint=gmem24

module load anaconda3
module list                            # Have Nvidia tell us the GPU/CPU mapping so we know
module load cuda/11.7
nvidia-smi topo -m
python3 main.py --train_classifier --gpu 0 --run_id ntu60cv --dataset ntu_rgbd_60 --model_version 'v3' --batch_size 8 --num_epochs 51 --num_workers 8 --learning_rate 1e-4 --weight_decay 1e-6 --optimizer ADAM
