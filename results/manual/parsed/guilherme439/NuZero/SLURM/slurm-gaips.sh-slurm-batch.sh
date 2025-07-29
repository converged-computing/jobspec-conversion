#!/bin/bash
#FLUX: --job-name=forgot_name
#FLUX: -c=8
#FLUX: -t=1152000
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=-1 python Run.py --training-preset 5 --name "not_a_name"
