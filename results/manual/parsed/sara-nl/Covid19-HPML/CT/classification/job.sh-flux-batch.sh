#!/bin/bash
#FLUX: --job-name=creamy-kitty-5005
#FLUX: --urgency=16

module use ~/environment-modules-lisa
module load 2020
module load TensorFlow/2.1.0-foss-2019b-Python-3.7.4-CUDA-10.1.243
conda deactivate
VIRTENV=covid19_classification
VIRTENV_ROOT=~/.virtualenvs
clear
source $VIRTENV_ROOT/$VIRTENV/bin/activate
python3 main.py --batch_size 16 --model covidnet_small --lr_scheduler step --img_size 299 --run_name small_299
