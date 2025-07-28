#!/bin/bash
#FLUX: --job-name=purple-blackbean-5672
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

export CUDA_VISIBLE_DEVICES=0
mpirun simpleMPI
