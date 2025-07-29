#!/bin/bash
#FLUX: --job-name=pytorch_mnist
#FLUX: -c=10
#FLUX: -t=10800
#FLUX: --urgency=16

set -x
cd $WORK/jean-zay-doc/examples/pytorch
module purge
module load pytorch-gpu/py3/1.4.0 
python ./mnist_example.py 
