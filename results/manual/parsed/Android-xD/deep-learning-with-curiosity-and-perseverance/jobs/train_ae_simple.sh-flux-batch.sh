#!/bin/bash
#FLUX: --job-name=train
#FLUX: -n=4
#FLUX: -t=86400
#FLUX: --urgency=16

source scripts/startup.sh
cd src/training
python train_autoencoder.py --experiment "simple"
cd ../evaluation
python eval_autoencoder.py --experimenet "simple"
