#!/bin/bash
#FLUX: --job-name=PB-UQ-train
#FLUX: -t=432000
#FLUX: --urgency=16

export JAX_ENABLE_X64='True'

export JAX_ENABLE_X64=True
python train.py
