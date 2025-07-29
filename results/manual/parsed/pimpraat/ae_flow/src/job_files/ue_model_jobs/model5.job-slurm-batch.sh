#!/bin/bash
#SBATCH --job-name=AE_NF_UE_Model1
#SBATCH --output=job_files/train.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=14:00:00

module purge
module load 2021
module load Anaconda3/2021.05
source activate dl2022
srun python -u train.py --epochs 100 --dataset chest_xray --subnet_architecture resnet_like --model ae_flow --n_validation_folds 5 --num_workers 3 --seed 1 --ue_model True
