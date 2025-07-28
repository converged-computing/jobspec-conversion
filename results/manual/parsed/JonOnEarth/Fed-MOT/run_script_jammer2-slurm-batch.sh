#!/bin/bash
#FLUX: --job-name=gpu_ja
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

source activate pytorch_env
python new_test_jammer2.py
