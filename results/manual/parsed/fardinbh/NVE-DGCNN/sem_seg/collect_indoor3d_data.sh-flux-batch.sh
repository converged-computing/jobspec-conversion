#!/bin/bash
#FLUX: --job-name=fat-nunchucks-9661
#FLUX: -c=12
#FLUX: -t=600
#FLUX: --urgency=16

module load cuda cudnn python/3.6
source ~/tensorflow/bin/activate
module load cuda
python ./collect_indoor3d_data.py
