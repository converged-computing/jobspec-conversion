#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=%x_%j.log
#SBATCH --mail-user=<Enter
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=90gb
#SBATCH --time=3-00:00:00
#SBATCH --partition=hpg-ai

module load singularity
singularity exec --nv <Enter path to MONAI container>/monaicore081 python3 -c "import torch; print(torch.cuda.is_available())"
singularity exec --nv --bind <Enter path to train file>:/mnt <Enter path to MONAI container>/monaicore081 python3 /mnt/train_domino.py --num_gpu 1 --data_dir '/mnt/<data folder name>/' --model_save_name "unetr_v5_domino_06-20-22" --N_classes 12 --max_iteration 100
