#!/bin/bash
#SBATCH --job-name=selfsupervised
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/DeepTreeAttention_%j.out
#SBATCH --error=/home/b.weinstein/logs/DeepTreeAttention_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50GB
#SBATCH --time=2-00:00:00

source activate DeepTreeAttention
cd ~/DeepTreeAttention/
python notebooks/crop_random_tile.py
