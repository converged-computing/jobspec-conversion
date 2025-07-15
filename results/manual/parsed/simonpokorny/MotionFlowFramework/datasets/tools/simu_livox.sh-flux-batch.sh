#!/bin/bash
#FLUX: --job-name=loopy-poo-9276
#FLUX: -c=4
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --priority=16

ml torchsparse
cd $HOME
python -u data_utils/livox/simu_livox.py
