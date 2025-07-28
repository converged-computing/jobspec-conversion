#!/bin/bash
#FLUX: --job-name=tf_setup
#FLUX: --queue=gpuA100
#FLUX: -t=7200
#FLUX: --urgency=16

uenv verbose cuda-11.8.0 cudnn-11.x-8.6.0
uenv verbose TensorRT-11.x-8.6-8.5.3.1
uenv verbose miniconda3-py310
conda create --name tf_env python=3.10
conda activate tf_env
pip install nvidia-cudnn-cu11==8.6.0.163 tensorrt==8.5.3.1 tensorflow==2.12.0 
pip install .
echo "Finished setting up."
