#!/bin/bash
#FLUX: --job-name=rainbow-gato-8272
#FLUX: --queue=bumblebee
#FLUX: -t=86400
#FLUX: --priority=16

source activate tensorflow
module load cudnn/7.0-9.0
python EDNN.py POTTS1 0 15 
