#!/bin/bash
#FLUX: --job-name=train
#FLUX: -t=86400
#FLUX: --urgency=16

source scripts/startup.sh
cd src/training
python train_variational_autoencoder.py
