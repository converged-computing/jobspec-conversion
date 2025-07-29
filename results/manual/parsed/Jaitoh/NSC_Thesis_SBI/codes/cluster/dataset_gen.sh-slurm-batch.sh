#!/bin/bash
#FLUX: --job-name=dataset_gen
#FLUX: -c=12
#FLUX: -t=86400
#FLUX: --urgency=16

module load anaconda3
source activate sbi
echo 'start generating dataset'
python3 ./src/data_generator/dataset_for_training.py
echo 'finished simulation'
squeue -u $USER
scancel --user=wehe
squeue -u $USER
squeue -u $USER
