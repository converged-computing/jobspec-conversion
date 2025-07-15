#!/bin/bash
#FLUX: --job-name=persnickety-eagle-8247
#FLUX: --priority=16

module load anaconda3/2019.07
source activate pytorch_1.11
python -u ./train_SimSwap.py --batchSize 32 --nThreads 32 --name SimSwap_nFM --no_ganFeat_loss
