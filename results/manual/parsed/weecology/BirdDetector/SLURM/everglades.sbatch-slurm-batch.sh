#!/bin/bash
#SBATCH --job-name=birddetector
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/DeepForest_%j.out
#SBATCH --error=/home/b.weinstein/logs/DeepForest_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=2
#SBATCH --mem=100GB
#SBATCH --time=12:00:00
#SBATCH --partition=gpu

source activate Zooniverse_pytorch
cd ~/BirdDetector/
python utils/everglades_mini.py
