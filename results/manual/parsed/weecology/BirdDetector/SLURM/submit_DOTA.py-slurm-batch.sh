#!/bin/bash
#SBATCH --job-name=DOTA
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/DOTA_%j.out
#SBATCH --error=/home/b.weinstein/logs/DOTA_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=1
#SBATCH --mem=80GB
#SBATCH --time=05:00:00

source activate Zooniverse_pytorch
python utils/DOTA_pretraining.py
