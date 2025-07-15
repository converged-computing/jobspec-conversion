#!/bin/bash
#FLUX: --job-name=spicy-fudge-9563
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate m3
python 4.loss_correction.py --experiment_name task4_server_cut1_pool --EPOCHS 300 --DATASET_DIR /ghome/group07/M3-Project-new/Week4/MIT_small_train_1
