#!/bin/bash
#FLUX: --job-name=tts8
#FLUX: -t=345600
#FLUX: --urgency=16

. /data/joohye/anaconda3/etc/profile.d/conda.sh
conda activate torch37
python train.py -p config/LibriTTS/preprocess.yaml -m config/LibriTTS/model.yaml -t config/LibriTTS/train.yaml --restore_step 80000
