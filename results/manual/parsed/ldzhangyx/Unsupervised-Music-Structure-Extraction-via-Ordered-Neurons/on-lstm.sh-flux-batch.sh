#!/bin/bash
#FLUX: --job-name=dirty-gato-8032
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=468000
#FLUX: --priority=16

python < /gpfsnyu/home/yz6492/on-lstm/code/main.py
