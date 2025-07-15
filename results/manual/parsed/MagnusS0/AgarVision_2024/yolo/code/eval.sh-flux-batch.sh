#!/bin/bash
#FLUX: --job-name=hc
#FLUX: --priority=16

nvidia-smi
CUDA_LAUNCH_BLOCKING=1 python eval.py
