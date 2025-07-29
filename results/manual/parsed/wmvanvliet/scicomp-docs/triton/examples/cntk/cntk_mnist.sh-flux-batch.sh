#!/bin/bash
#FLUX --job-name=doopy-underoos-0364
#FLUX -t=900
#FLUX --urgency=16

module load nvidia-cntk
singularity_wrapper exec python cntk_mnist.py
