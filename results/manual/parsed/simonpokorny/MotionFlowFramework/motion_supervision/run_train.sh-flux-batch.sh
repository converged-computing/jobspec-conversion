#!/bin/bash
#FLUX: --job-name=eccentric-leopard-4082
#FLUX: -c=8
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

ml torchsparse
cd $HOME
python -u motion_supervision/train.py
