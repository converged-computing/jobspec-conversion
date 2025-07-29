#!/bin/bash
#FLUX --job-name=nerdy-noodle-5096
#FLUX --queue=gpu
#FLUX --urgency=16

module load pytorch/nvidia-20.03-py3
singularity_wrapper exec python monobeast.py $*
