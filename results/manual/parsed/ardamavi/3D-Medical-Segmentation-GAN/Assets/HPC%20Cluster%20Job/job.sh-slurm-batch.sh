#!/bin/bash
#FLUX: --job-name=3DSeg
#FLUX: --queue=ai
#FLUX: -t=86400
#FLUX: --urgency=16

echo "Running Job"
python train.py
