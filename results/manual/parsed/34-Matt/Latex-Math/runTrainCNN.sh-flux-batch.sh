#!/bin/bash
#FLUX: --job-name=TrainCNN
#FLUX: -t=259200
#FLUX: --priority=16

module purge
module load apps/python3
pip install --user --upgrade tensorflow
pip install tensorflow-gpu
pip install --user numpy
python TrainCNN.py
