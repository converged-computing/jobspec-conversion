#!/bin/bash
#FLUX: --job-name=rainbow-hope-2828
#FLUX: -n=8
#FLUX: -t=86400
#FLUX: --urgency=16

module load eth_proxy
module load gcc/9.3.0
module load cuda/11.7.0
conda activate thesis
python3 toy_test.py
