#!/bin/bash
#FLUX: --job-name=icarl_5
#FLUX: -c=2
#FLUX: -t=43200
#FLUX: --priority=16

if [ $# -ne 1 ]; then
  exit
fi
ml purge
ml PyTorch/0.4.0-gomkl-2018b-Python-2.7.15-CUDA-9.2.88
ml torchvision/0.2.1-gomkl-2018b-Python-2.7.15-CUDA-9.2.88 
echo 'Starting job'
python main.py "$1"
