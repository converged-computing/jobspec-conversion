#!/bin/bash
#FLUX: --job-name=torch-test
#FLUX: -c=8
#FLUX: -t=604800
#FLUX: --urgency=16

MODEL_DIR="./outputs"
echo $(pwd)
tensorboard --logdir="${MODEL_DIR}" 
