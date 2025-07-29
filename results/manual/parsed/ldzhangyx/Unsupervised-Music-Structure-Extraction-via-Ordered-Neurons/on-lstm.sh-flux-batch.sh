#!/bin/bash
#FLUX --job-name=blue-underoos-5040
#FLUX -c=8
#FLUX --queue=gpu
#FLUX -t=468000
#FLUX --urgency=16

python < /gpfsnyu/home/yz6492/on-lstm/code/main.py
