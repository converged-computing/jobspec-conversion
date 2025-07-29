#!/bin/bash
#FLUX: --job-name=joyous-despacito-3514
#FLUX: -t=900
#FLUX: --urgency=16

module load nvidia-cntk
singularity_wrapper exec python cntk_mnist.py
