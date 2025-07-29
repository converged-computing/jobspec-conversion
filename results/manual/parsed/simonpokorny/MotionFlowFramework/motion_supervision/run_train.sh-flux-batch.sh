#!/bin/bash
#FLUX --job-name=chunky-hope-0604
#FLUX -c=8
#FLUX --queue=amdgpufast
#FLUX -t=14400
#FLUX --urgency=16

ml torchsparse
cd $HOME
python -u motion_supervision/train.py
