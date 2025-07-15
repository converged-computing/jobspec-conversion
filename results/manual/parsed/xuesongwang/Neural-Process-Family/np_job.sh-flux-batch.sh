#!/bin/bash
#FLUX: --job-name=lovable-lemon-5377
#FLUX: -t=12600
#FLUX: --priority=16

source /scratch1/wan410/venv/bin/activate                                             # use the virtual environment
python3 ConvNP_train.py --kernel1 0 --kernel2 1   # do not load pytorch when running ConvNP models
