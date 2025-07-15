#!/bin/bash
#FLUX: --job-name=carnivorous-staircase-2328
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate m3
python 5.hyperparameters.py --experiment_name task5_cut1_pool --EPOCHS 300 --DATASET_DIR /ghome/group07/M3-Project-new/Week4/MIT_small_train_1
