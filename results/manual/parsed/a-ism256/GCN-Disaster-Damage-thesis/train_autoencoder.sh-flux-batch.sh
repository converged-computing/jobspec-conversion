#!/bin/bash
#FLUX: --job-name=autoencoder
#FLUX: --queue=msfea-ai
#FLUX: --priority=16

module purge
module load python/tensorflow-2.3.1
module load cuda
python3 train_autoencoder.py
