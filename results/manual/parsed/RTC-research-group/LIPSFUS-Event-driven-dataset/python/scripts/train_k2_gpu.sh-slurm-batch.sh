#!/bin/bash
#SBATCH --job-name=NN_trainner
#SBATCH --output=./logs/visual_NN_trainner_%j.log
#SBATCH --mail-user=arios@us.es
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=10:00:00
#SBATCH --partition=k2-gpu

module add libs/nvidia-cuda/11.0.3/bin
module add apps/anaconda3/5.2.0/bin
source ~/.bashrc
conda activate /mnt/scratch2/users/arios/conda/envs/sensory-fusion
nvidia-smi
python visual_NN_classifier.py
