#!/bin/bash
#FLUX: --job-name=train
#FLUX: -n=4
#FLUX: -t=86400
#FLUX: --urgency=16

source scripts/startup.sh
cd third_party/colorization-autoencoder
python train.py --train_list "perseverance_navcam_color" --parallel 0 --batch-size 32 -j 1 --pth-save-fold "/cluster/scratch/horatan/mars/results" --epochs 100
