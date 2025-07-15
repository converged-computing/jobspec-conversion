#!/bin/bash
#FLUX: --job-name=joyous-knife-7179
#FLUX: -N=2
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

export CUDA_VISIBLE_DEVICES=0
mpirun simpleMPI
