#!/bin/bash
#FLUX: --job-name=blue-peas-9355
#FLUX: -c=4
#FLUX: --queue=amdgpufast
#FLUX: -t=14400
#FLUX: --urgency=16

ml torchsparse
cd $HOME
python -u data_utils/livox/simu_livox.py
