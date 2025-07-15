#!/bin/bash
#FLUX: --job-name=pusheena-staircase-8161
#FLUX: --priority=16

module load tensorflow/intel-1.13.1-py36
script=mnist.py
path=hpo/mnist-lenet5/source
cd $path && python $script
