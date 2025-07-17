#!/bin/bash
#FLUX: --job-name=PrimeNet
#FLUX: --queue=gpu
#FLUX: -t=720000
#FLUX: --urgency=16

python -u ./main.py
