#!/bin/bash
#FLUX --job-name=loopy-mango-6157
#FLUX -c=8
#FLUX --queue=amdgpufast
#FLUX -t=14400
#FLUX --urgency=16

ml torchsparse
cd $HOME
python -u motion_supervision/train.py
