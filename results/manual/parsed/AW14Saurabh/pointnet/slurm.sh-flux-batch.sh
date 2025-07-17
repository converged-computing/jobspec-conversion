#!/bin/bash
#FLUX: --job-name=PointNet
#FLUX: -t=9000
#FLUX: --urgency=16

hostname
module load tensorflow/1.14.0
. /util/common/tensorflow/1.14.0/py36/anaconda3-5.2.0/etc/profile.d/conda.sh
conda activate tensorflow-gpu
date
python train.py
date
conda deactivate
module unload tensorflow/1.14.0
