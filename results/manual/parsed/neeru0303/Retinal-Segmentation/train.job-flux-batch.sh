#!/bin/bash
#FLUX: --job-name=angry-noodle-4913
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1'
export TENSORFLOW_ENV='$TF_ENV'

set -x
export CUDA_VISIBLE_DEVICES=0,1
module load tensorflow/1.5_gpu
module load keras/2.0.4
export TENSORFLOW_ENV=$TF_ENV
source $KERAS_ENV/bin/activate
cd $HOME
cd r2/Retinal-Segmentation
python python/main_model.py --classification 4 --dataset big --cache --activation relu
echo "ALL DONE!"
