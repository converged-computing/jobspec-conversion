#!/bin/bash
#FLUX: --job-name=quirky-truffle-6207
#FLUX: -c=8
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --priority=16

ml torchsparse
cd $HOME
python -u motion_supervision/train.py
