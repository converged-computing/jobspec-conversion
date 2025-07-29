#!/bin/bash
#SBATCH --job-name=NLUModel-Run1
#SBATCH --mail-user=ncwn67@durham.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu
#SBATCH --time=05:00:00
#SBATCH --qos=short

source /etc/profile
module load cuda/8.0
python /home2/ncwn67/A-Hackers-AI-Voice-Assistant/VoiceAssistant/nlu/neuralnet/train.py
