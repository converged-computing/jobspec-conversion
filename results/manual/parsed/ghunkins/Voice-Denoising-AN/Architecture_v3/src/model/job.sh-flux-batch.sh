#!/bin/bash
#FLUX: --job-name=pix
#FLUX: --priority=16

source activate new_pix
python main.py --backend tensorflow --dset audio_10000_new --nb_epoch 400 --img_dim 256 256 256
