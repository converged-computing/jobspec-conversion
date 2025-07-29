#!/bin/bash
#SBATCH --job-name=RunAE_Normalized_Flow_Development
#SBATCH --output=job_files/train.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=00:20:00

module purge
module load 2021
module load Anaconda3/2021.05
source activate dl2022
srun python -u train.py --dataset chest_xray --subnet_architecture resnet_like --model ae_flow --final_experiments False -fully_deterministic True --epochs 100 --seed 42 
srun python -u train.py --dataset chest_xray --loss_beta 0.0 --model ae_flow --final_experiments False -fully_deterministic True --epochs 100 --seed 42 
