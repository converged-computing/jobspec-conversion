#!/bin/bash
#FLUX --job-name=placid-knife-4657
#FLUX -t=900
#FLUX --urgency=16

module load nvidia-cntk
singularity_wrapper exec python cntk_mnist.py
