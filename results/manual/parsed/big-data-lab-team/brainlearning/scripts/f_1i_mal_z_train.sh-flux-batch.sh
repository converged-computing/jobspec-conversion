#!/bin/bash
#FLUX: --job-name=conspicuous-soup-5253
#FLUX: -c=6
#FLUX: -t=120
#FLUX: --urgency=16

model=f_1i_mal_z
module load cuda cudnn python/3.6.3
echo "Present working directory is $PWD"
source $HOME/tensorflow/bin/activate
python $HOME/brainlearning/brainlearning/operations.py --mode train --model $model --batch_size 4 --n_channels 1 --steps_per_epoch 1 --epochs 250 --save_each_epochs 20 --save_each_epochs_dir $HOME/scratch/model/$model/ --images_dir_path ../project/ml-bet/ --verbose 2
