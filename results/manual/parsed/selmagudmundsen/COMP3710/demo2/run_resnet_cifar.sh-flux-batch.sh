#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=vgpu
#FLUX: --urgency=16

conda activate env1
python cifar10.py
