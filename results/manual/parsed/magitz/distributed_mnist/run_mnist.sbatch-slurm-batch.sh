#!/bin/bash
#FLUX: --job-name=mnist_2GPUs
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

pwd; hostname; date           # Print some useful info
module load tensorflow/2.7.0        # Be sure to load the tensorflow module
echo "Running mnist script"
python distributed_mnist.py  # Run the script
date
