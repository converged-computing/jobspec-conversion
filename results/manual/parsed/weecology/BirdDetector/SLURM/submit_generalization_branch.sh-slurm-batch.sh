#!/bin/bash
#SBATCH --job-name=birddetector
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/DeepForest_%j.out
#SBATCH --error=/home/b.weinstein/logs/DeepForest_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --gres=1
#SBATCH --mem=30GB
#SBATCH --time=2-00:00:00

sbatch <<EOT
ulimit -c 0
source activate Zooniverse_pytorch
cd ~/BirdDetector/
module load git
git checkout $1
python generalization.py
EOT
