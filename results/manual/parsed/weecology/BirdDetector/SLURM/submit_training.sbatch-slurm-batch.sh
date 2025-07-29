#!/bin/bash
#SBATCH --job-name=DeepForest
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/Palmyra_%j.out
#SBATCH --error=/home/b.weinstein/logs/Palmyra_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=1
#SBATCH --mem=80GB
#SBATCH --time=07:00:00

source activate Zooniverse_pytorch
python training_loop.py
