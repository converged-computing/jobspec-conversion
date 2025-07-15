#!/bin/bash
#FLUX: --job-name=ser
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate ser
echo "Running run.py"
python run.py
