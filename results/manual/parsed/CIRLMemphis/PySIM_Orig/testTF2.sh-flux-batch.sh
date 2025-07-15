#!/bin/bash
#FLUX: --job-name=arid-gato-1802
#FLUX: -c=4
#FLUX: --queue=gpuq
#FLUX: -t=600
#FLUX: --priority=16

python testTF2.py
