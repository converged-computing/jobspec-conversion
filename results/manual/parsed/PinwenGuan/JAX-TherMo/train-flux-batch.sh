#!/bin/bash
#FLUX: --job-name=confused-frito-7906
#FLUX: -t=432000
#FLUX: --priority=16

export JAX_ENABLE_X64='True'

export JAX_ENABLE_X64=True
python train.py
