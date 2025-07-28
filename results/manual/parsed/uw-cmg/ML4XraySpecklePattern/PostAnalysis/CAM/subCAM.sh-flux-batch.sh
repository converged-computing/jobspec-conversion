#!/bin/bash
#FLUX: --job-name=crunchy-muffin-5386
#FLUX: --queue=sbel_cmg
#FLUX: -t=345660
#FLUX: --urgency=16

conda activate keras
module load cuda/10.0
python genCAM.py
