#!/bin/bash
#FLUX: --job-name=swampy-earthworm-8592
#FLUX: -t=900
#FLUX: --urgency=16

module load nvidia-cntk
singularity_wrapper exec python cntk_mnist.py
