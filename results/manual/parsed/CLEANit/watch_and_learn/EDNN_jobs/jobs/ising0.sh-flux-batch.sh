#!/bin/bash
#FLUX: --job-name=eccentric-nalgas-4259
#FLUX: --queue=bumblebee
#FLUX: -t=86400
#FLUX: --urgency=16

source activate tensorflow
module load cudnn/7.0-9.0
python EDNN.py ISING1 0 15 
