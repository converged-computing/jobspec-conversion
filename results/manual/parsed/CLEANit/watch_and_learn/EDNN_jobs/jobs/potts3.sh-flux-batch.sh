#!/bin/bash
#FLUX: --job-name=chunky-cherry-6766
#FLUX: --queue=bumblebee
#FLUX: -t=86400
#FLUX: --urgency=16

source activate tensorflow
module load cudnn/7.0-9.0
python EDNN.py POTTS1 45 60 -l
