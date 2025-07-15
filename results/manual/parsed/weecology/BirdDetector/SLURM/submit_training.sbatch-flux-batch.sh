#!/bin/bash
#FLUX: --job-name=DeepForest
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=25200
#FLUX: --urgency=16

source activate Zooniverse_pytorch
python training_loop.py
