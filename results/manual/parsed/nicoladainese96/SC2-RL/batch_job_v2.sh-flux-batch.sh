#!/bin/bash
#FLUX: --job-name=eccentric-bits-7030
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load pytorch/nvidia-20.03-py3
singularity_wrapper exec python monobeast_v2.py $*
