#!/bin/bash
#SBATCH --job-name=CS 601.471/671 homework6 3.1.2
#SBATCH --output=slurm-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=2

module load anaconda 
source ~/.bashrc
conda activate ssm_hw6 # activate the Python environment
python base_classification.py --device cuda --model "distilbert-base-uncased" --batch_size "32" --lr 1e-4 --num_epochs 30
