#!/bin/bash
#FLUX: --job-name=NLUModel-Run1
#FLUX: -c=2
#FLUX: --queue=ug-gpu-small
#FLUX: -t=18000
#FLUX: --urgency=16

source /etc/profile
module load cuda/8.0
python /home2/ncwn67/A-Hackers-AI-Voice-Assistant/VoiceAssistant/nlu/neuralnet/train.py
