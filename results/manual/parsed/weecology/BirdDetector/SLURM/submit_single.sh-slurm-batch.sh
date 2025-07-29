#!/bin/bash
#SBATCH --job-name=birddetector
#SBATCH --account=ewhite
#SBATCH --output=/home/b.weinstein/logs/DeepForest_%j.out
#SBATCH --error=/home/b.weinstein/logs/DeepForest_%j.err
#SBATCH --mail-user=benweinstein2010@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=$2
#SBATCH --mem=80GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

sbatch <<EOT
ulimit -c 0
NCCL_DEBUG=INFO
source activate Zooniverse_pytorch
cd ~/BirdDetector/
module load git
git checkout $1
python single_run.py $3
EOT
