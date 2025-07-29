#!/bin/bash
#FLUX: --job-name=pfenet
#FLUX: -t=3600
#FLUX: --urgency=16

echo "Executing on $HOSTNAME"
date
module load nvidia/latest
module load cudnn/latest
CUDA_LAUNCH_BLOCKING=1 python3 test_pfenet.py
