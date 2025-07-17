#!/bin/bash
#FLUX: --job-name=FredericMasterThesisGAN
#FLUX: -t=300
#FLUX: --urgency=16

module load python/3.8.7
module load cuda/11.0
module load cudnn/8.0.5
pip3 install --user tensorflow
python3 trainer/TrainNeuralNetwork.py
