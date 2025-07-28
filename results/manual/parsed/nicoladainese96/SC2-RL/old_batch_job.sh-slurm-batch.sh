#!/bin/bash
#FLUX: --job-name=boopy-lettuce-2809
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load pytorch/nvidia-20.03-py3
singularity_wrapper exec python -u run.py $*
