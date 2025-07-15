#!/bin/bash
#FLUX: --job-name=gassy-hope-8679
#FLUX: -c=42
#FLUX: --queue=small
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module load pytorch/1.12.1
source activate ldm
cd latent-diffusion
CUDA_VISIBLE_DEVICES=0 python scripts/evaluation.py
