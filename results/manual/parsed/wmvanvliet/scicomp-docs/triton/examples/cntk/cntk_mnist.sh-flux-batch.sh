#!/bin/bash
#FLUX: --job-name=doopy-truffle-9739
#FLUX: -t=900
#FLUX: --urgency=16

module load nvidia-cntk
singularity_wrapper exec python cntk_mnist.py
