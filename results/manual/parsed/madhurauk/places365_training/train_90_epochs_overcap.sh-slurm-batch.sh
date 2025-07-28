#!/bin/bash
#FLUX: --job-name=resnet18
#FLUX: --queue=overcap
#FLUX: --urgency=16

source /nethome/mummettuguli3/anaconda2/bin/activate
conda activate my_basic_env_3
python train_placesCNN.py -a resnet18 --workers 40 /coc/scratch/mummettuguli3/data/places365_3/places365_standard
