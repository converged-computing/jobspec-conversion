#!/bin/bash
#FLUX: --job-name=cifar-resnet
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

module load anaconda
module load use.own
conda env remove --name d22env
conda create --name d22env python=3.11 jupyter pytorch torchvision matplotlib pandas -y
source activate d22env
conda info --envs
echo -e "module loaded"
