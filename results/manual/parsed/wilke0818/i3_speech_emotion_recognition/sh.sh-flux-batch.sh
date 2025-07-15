#!/bin/bash
#FLUX: --job-name=ser
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate ser
echo "Running run.py"
python run.py
