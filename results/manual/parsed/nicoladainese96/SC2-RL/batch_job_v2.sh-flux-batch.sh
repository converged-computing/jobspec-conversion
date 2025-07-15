#!/bin/bash
#FLUX: --job-name=red-cattywampus-7212
#FLUX: --queue=gpu
#FLUX: --priority=16

module load pytorch/nvidia-20.03-py3
singularity_wrapper exec python monobeast_v2.py $*
