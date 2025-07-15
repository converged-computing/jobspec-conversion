#!/bin/bash
#FLUX: --job-name=phat-bits-4614
#FLUX: -N=2
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0'

export CUDA_VISIBLE_DEVICES=0
mpirun simpleMPI
