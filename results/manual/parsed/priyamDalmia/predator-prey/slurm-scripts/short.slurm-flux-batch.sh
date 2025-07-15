#!/bin/bash
#FLUX: --job-name=persnickety-frito-8185
#FLUX: --queue=shortgpgpu
#FLUX: -t=3600
#FLUX: --priority=16

module load pytorch/1.5.1-python-3.7.4
python3 trainers/tprey.py
