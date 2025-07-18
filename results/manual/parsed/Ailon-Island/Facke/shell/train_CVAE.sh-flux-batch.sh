#!/bin/bash
#FLUX: --job-name=Facke_CVAE_New_Generator
#FLUX: --queue=gpu
#FLUX: -t=900000
#FLUX: --urgency=16

module load anaconda3/2019.07
source activate pytorch_1.11
python -u ./train_CVAE.py --model CVAE --batchSize 32 --name CVAE_GAN --display_freq 2000 --no_intra_ID_random --print_freq 2400
