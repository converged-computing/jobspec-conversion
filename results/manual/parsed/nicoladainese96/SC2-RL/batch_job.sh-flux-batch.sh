#!/bin/bash
#FLUX: --job-name=astute-squidward-6320
#FLUX: --queue=gpu
#FLUX: --priority=16

module load pytorch/nvidia-20.03-py3
singularity_wrapper exec python monobeast.py $*
