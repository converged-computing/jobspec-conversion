#!/bin/bash
#FLUX: --job-name=reclusive-despacito-0454
#FLUX: --queue=gpu
#FLUX: --priority=16

module load pytorch/nvidia-20.03-py3
singularity_wrapper exec python -u run.py $*
