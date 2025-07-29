#!/bin/bash
#FLUX --job-name=delicious-cherry-2604
#FLUX -t=12600
#FLUX --urgency=16

source /scratch1/wan410/venv/bin/activate                                             # use the virtual environment
python3 ConvNP_train.py --kernel1 0 --kernel2 1   # do not load pytorch when running ConvNP models
