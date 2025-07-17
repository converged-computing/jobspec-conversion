#!/bin/bash
#FLUX: --job-name=hanky-lemur-9833
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load pytorch/nvidia-20.03-py3
singularity_wrapper exec python -u run.py $*
