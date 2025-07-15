#!/bin/bash
#FLUX: --job-name=tensorflow_gpu_demo
#FLUX: --priority=16

module load CUDA cuDNN anaconda
conda activate tensorflow-gpu
python multilayer_perceptron.py
