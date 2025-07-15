#!/bin/bash
#FLUX: --job-name=HAE
#FLUX: --queue=gpu
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/local/nvidia/lib'

eval "$(/opt/app/anaconda3/bin/conda shell.bash hook)"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/nvidia/lib
conda create -n HAE python=3.7 pytorch=1.10 cudatoolkit=11.1 torchvision -c pytorch -y
conda activate HAE
pip3 install openmim
mim install mmcv-full
pip3 install -e .
