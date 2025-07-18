#!/bin/bash
#FLUX: --job-name=buttery-destiny-7825
#FLUX: -c=6
#FLUX: -t=30
#FLUX: --urgency=16

model=f_1i_mal_y
module load cuda cudnn python/3.6.3
echo "Present working directory is $PWD"
source $HOME/tensorflow/bin/activate
python $HOME/brainlearning/brainlearning/operations.py --mode generate --model $model --model_dir $model/ --images_dir_path ../project/ml-bet/
