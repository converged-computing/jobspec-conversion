#!/bin/bash
#FLUX: --job-name=confused-frito-2184
#FLUX: -c=6
#FLUX: -t=180
#FLUX: --urgency=16

module load cuda cudnn python/3.6.3
echo "Present working directory is $PWD"
source $HOME/tensorflow/bin/activate
python $HOME/brainlearning/brainlearning/operations.py --mode continue --model small --model_dir small/ --batch_size 10 --steps_per_epoch 1 --epochs 250 --save_each_epochs 50 --images_dir_path ../project/ml-bet/ --verbose 2
