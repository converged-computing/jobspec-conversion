#!/bin/bash
#FLUX: --job-name=crusty-platanos-6624
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=468000
#FLUX: --urgency=16

python < /gpfsnyu/home/yz6492/on-lstm/code/main.py
