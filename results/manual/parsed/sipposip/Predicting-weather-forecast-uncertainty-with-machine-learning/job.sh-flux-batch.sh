#!/bin/bash
#FLUX: --job-name=dinosaur-eagle-4410
#FLUX: --exclusive
#FLUX: -t=10800
#FLUX: --urgency=16

export KERAS_BACKEND='tensorflow'

ml icc/2017.1.132-GCC-5.4.0-2.26
ml ifort/2017.1.132-GCC-5.4.0-2.26
ml CUDA/8.0.44 impi/2017.1.132
ml Python/3.6.1
ml Tensorflow/1.3.0-Python-3.6.1
ml Keras/2.1.2-Python-3.6.1
ml matplotlib/2.0.1-Python-3.6.1 scikit-learn/0.18.1-Python-3.6.1
export KERAS_BACKEND=tensorflow
srun python GEFS_error_regression_CNN_kebnekaise_v33.py
