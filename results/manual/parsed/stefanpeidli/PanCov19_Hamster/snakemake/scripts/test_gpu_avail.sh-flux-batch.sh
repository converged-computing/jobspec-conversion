#!/bin/bash
#FLUX: --job-name=stinky-cherry-3015
#FLUX: -n=2
#FLUX: --queue=gpu-el8
#FLUX: --urgency=16

python scripts/test_gpu_avail.py
