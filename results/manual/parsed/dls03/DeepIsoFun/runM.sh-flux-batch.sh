#!/bin/bash
#FLUX: --job-name=rM
#FLUX: -t=260100
#FLUX: --urgency=16

date
module load caffe
module load cuda/8.0
module load cuDNN/6.0
module load opencv
module load glog
python DeepIsoFun/deepisofun3.py
