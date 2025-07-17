#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=2
#FLUX: --queue=E5-GPU
#FLUX: -t=600
#FLUX: --urgency=16

env
echo "--- *** --- *** ---"
nvidia-smi
