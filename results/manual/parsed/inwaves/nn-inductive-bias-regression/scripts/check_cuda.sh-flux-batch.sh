#!/bin/bash
#FLUX: --job-name=check-cuda
#FLUX: --queue=ampere
#FLUX: --urgency=16

python3 check_cuda.py
