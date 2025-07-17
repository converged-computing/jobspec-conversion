#!/bin/bash
#FLUX: --job-name=purple-knife-1755
#FLUX: -n=2
#FLUX: --queue=gpu-el8
#FLUX: --urgency=16

python scripts/test_gpu_avail.py
