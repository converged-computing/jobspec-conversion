#!/bin/bash
#FLUX: --job-name=tensorflow_gpu_demo
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load CUDA cuDNN anaconda
conda activate tensorflow-gpu
python multilayer_perceptron.py
