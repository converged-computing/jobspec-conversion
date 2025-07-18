#!/bin/bash
#FLUX: --job-name=pix
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

source activate new_pix
python main.py --backend tensorflow --dset audio_1000 --nb_epoch 400 64 64
