#!/bin/bash
#FLUX: --job-name=Facke_cont_WO_intra-Id_random
#FLUX: --queue=gpu
#FLUX: -t=900000
#FLUX: --urgency=16

module load anaconda3/2019.07
source activate pytorch_1.11
python -u ./train_SimSwap.py --batchSize 32 --continue_train --epoch_label 1108511_iter --name SimSwap_WO_intra-ID_random --nThreads 32 --no_intra_ID_random
