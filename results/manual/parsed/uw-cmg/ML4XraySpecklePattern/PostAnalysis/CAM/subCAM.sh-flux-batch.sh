#!/bin/bash
#FLUX: --job-name=wobbly-caramel-2792
#FLUX: --queue=sbel_cmg
#FLUX: -t=345660
#FLUX: --urgency=16

conda activate keras
module load cuda/10.0
python genCAM.py
