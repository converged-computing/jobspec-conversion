#!/bin/bash
#FLUX --job-name=frigid-mango-4744
#FLUX -N=2
#FLUX -n=2
#FLUX --urgency=16

export CUDA_VISIBLE_DEVICES='0'

export CUDA_VISIBLE_DEVICES=0
mpirun simpleMPI
