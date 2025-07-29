#!/bin/bash
#SBATCH --job-name=Everglades
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/Everglades_%j.out
#SBATCH --error=/home/b.weinstein/logs/Everglades_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=4
#SBATCH --mem=80GB
#SBATCH --time=05:00:00
#SBATCH --partition=gpu

source activate Zooniverse_pytorch
python everglades.py
