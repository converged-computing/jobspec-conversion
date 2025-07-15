#!/bin/bash
#FLUX: --job-name=delicious-cinnamonbun-2112
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --priority=16

module load Python/3.5.2-intel-2017.u2-GCC-5.4.0-CUDA8
module load Tensorflow/1.4.0-intel-2017.u2-GCC-5.4.0-CUDA8-Python-3.5.2-GPU
module load Keras/2.1.5-intel-2017.u2-GCC-5.4.0-CUDA8-Python-3.5.2-GPU
module load CUDA/8.0.44
module load matplotlib/1.5.1-intel-2017.u2-GCC-5.4.0-CUDA8-Python-3.5.2
echo "Searching for mentions"
time mpiexec -n 1 python3 dnn_regress.py
