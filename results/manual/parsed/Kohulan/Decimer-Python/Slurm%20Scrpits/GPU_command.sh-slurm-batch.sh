#!/bin/bash
#FLUX: --job-name=rainbow-general-4357
#FLUX: -c=48
#FLUX: --queue=gpu_v100
#FLUX: -t=720000
#FLUX: --urgency=16

module load nvidia/cuda/9 #loading Modules
module load tools/tensorflow/1.8.0
time python Cnn_modified_alexnet.py # Command to run the desired code
