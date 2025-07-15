#!/bin/bash
#FLUX: --job-name=NLUModel-Run1
#FLUX: --priority=16

source /etc/profile
module load cuda/8.0
python /home2/ncwn67/A-Hackers-AI-Voice-Assistant/VoiceAssistant/nlu/neuralnet/train.py
