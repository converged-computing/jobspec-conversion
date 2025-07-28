#!/bin/bash
#FLUX: --job-name=sticky-spoon-0160
#FLUX: --queue=genoa
#FLUX: -t=14400
#FLUX: --urgency=16

module load 2022
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
python -u blur-images.py
