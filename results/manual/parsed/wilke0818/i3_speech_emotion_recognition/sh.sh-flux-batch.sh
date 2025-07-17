#!/bin/bash
#FLUX: --job-name=ser
#FLUX: -n=8
#FLUX: --queue=gablab
#FLUX: -t=345600
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate ser
echo "Running run.py"
python run.py
