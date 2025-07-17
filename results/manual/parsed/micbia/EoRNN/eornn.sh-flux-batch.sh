#!/bin/bash
#FLUX: --job-name=scruptious-lentil-8853
#FLUX: -N=4
#FLUX: -n=12
#FLUX: --queue=mem192
#FLUX: -t=86400
#FLUX: --urgency=16

module load Python
module load scikit
module load Keras
module load TensorFlow
module load CUDA
python TrainingEoRNN.py
