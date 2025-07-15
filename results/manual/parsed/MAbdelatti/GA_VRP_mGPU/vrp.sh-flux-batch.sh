#!/bin/bash
#FLUX: --job-name=carnivorous-kitty-2293
#FLUX: --priority=16

python3 gpu.py P-n16-k8 2000 450 20 60 30
