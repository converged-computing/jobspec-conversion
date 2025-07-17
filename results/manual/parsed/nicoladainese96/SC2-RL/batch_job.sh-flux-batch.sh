#!/bin/bash
#FLUX: --job-name=angry-sundae-9031
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load pytorch/nvidia-20.03-py3
singularity_wrapper exec python monobeast.py $*
