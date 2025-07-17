#!/bin/bash
#FLUX: --job-name=pytorch_mnist
#FLUX: --queue=gpuA100
#FLUX: -t=8100
#FLUX: --urgency=16

uenv verbose cuda-11.4 cudnn-11.4-8.2.4
uenv miniconda-python39
conda activate pytorch_env
python -u pytorch_mnist.py
