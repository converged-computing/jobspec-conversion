#!/bin/bash
#FLUX: --job-name=zlyn
#FLUX: --queue=gpulab02
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1'

export CUDA_VISIBLE_DEVICES=0,1
nvidia-smi
