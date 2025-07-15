#!/bin/bash
#FLUX: --job-name=lovable-cherry-3646
#FLUX: -t=3600
#FLUX: --priority=16

echo "Executing on $HOSTNAME"
date
module load nvidia/latest
module load cudnn/latest
CUDA_LAUNCH_BLOCKING=1 python3 test_pfenet.py
