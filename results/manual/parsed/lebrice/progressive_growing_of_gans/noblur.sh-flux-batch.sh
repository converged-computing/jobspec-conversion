#!/bin/bash
#FLUX: --job-name=expressive-pedo-9966
#FLUX: -t=172800
#FLUX: --urgency=16

cd ~/IFT6085/progressive_growing_of_gans
source ~/miniconda3/bin/activate
conda activate tensorflow1
git checkout master
git pull
cp -r --no-clobber datasets /Tmp/pichetre/ -v
python ./train.py --blur-schedule NOBLUR --train-k-images 1000
