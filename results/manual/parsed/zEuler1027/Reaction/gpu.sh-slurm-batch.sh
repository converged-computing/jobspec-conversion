#!/bin/bash
#FLUX: --job-name=DDPM
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load conda
conda activate oa_reactdiff
python train.py
