#!/bin/bash
#FLUX: --job-name=loopy-ricecake-4234
#FLUX: -c=6
#FLUX: -t=180
#FLUX: --urgency=16

module load cuda cudnn python/3.6.3
echo "Present working directory is $PWD"
source $HOME/tensorflow/bin/activate
python $HOME/brainlearning/brainlearning/operations.py --mode generate --model small --model_dir small/ --images_dir_path ../project/ml-bet/
