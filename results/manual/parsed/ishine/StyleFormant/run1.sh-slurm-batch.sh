#!/bin/bash
#SBATCH --job-name=tts8
#SBATCH --output=slurm_10_80000.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=4-00:00:00

. /data/joohye/anaconda3/etc/profile.d/conda.sh
conda activate torch37
python train.py -p config/LibriTTS/preprocess.yaml -m config/LibriTTS/model.yaml -t config/LibriTTS/train.yaml --restore_step 80000
