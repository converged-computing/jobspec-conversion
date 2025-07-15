#!/bin/bash
#FLUX: --job-name=m2_valid
#FLUX: --queue=gpus
#FLUX: -t=864000
#FLUX: --urgency=16

module purge
module load intel-python3
conda activate galnet
PYTHONHASHSEED=0 python galnet/galnet.py --train --model model-2
