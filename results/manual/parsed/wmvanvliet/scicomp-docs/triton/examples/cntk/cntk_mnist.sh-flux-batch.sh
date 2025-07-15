#!/bin/bash
#FLUX: --job-name=bricky-hippo-4631
#FLUX: -t=900
#FLUX: --priority=16

module load nvidia-cntk
singularity_wrapper exec python cntk_mnist.py
