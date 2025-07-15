#!/bin/bash
#FLUX: --job-name=red-salad-1241
#FLUX: -c=20
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --priority=16

module load modenv/ml
module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
cd /home/cherold/workspace/python/tf-examples/mnist_cnn
./measure_epochs.sh
