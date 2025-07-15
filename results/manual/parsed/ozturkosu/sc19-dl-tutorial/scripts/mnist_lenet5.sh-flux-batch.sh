#!/bin/bash
#FLUX: --job-name=fuzzy-pot-5456
#FLUX: --urgency=16

module load tensorflow/intel-1.13.1-py36
script=mnist.py
path=hpo/mnist-lenet5/source
cd $path && python $script
