#!/bin/bash
#FLUX: --job-name=stanky-plant-2750
#FLUX: --queue=sbel_cmg
#FLUX: -t=345660
#FLUX: --urgency=16

conda activate keras
module load cuda/10.0
python genCAM.py
