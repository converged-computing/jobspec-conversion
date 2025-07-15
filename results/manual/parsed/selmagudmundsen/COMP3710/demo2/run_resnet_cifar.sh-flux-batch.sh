#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=vgpu
#FLUX: --priority=16

conda activate env1
python cifar10.py
