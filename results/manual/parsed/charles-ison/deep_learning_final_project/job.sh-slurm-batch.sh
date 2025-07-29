#!/bin/bash
#SBATCH --job-name=stemgen
#SBATCH --output=logs/train_model.out
#SBATCH --error=logs/train_model.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:8
#SBATCH --mem=256G
#SBATCH --time=1-00:00:00
#SBATCH --partition=dgx2
#SBATCH --nodelist=dgx2-6

module load python/3.10 cuda/11.7 sox
source env/bin/activate
python train_model.py
