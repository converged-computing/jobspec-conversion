#!/bin/bash
#SBATCH --account=cmg
#SBATCH --output=cuda_Training-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=4-00:01:00
#SBATCH --partition=sbel_cmg
#SBATCH --qos=cmg_owner

conda activate keras
module load cuda/10.0
python train_resnet50.py --dataset ../data --savedResults saved --trainingLog logs 
