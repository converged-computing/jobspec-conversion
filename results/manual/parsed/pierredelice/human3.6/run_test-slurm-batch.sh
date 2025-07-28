#!/bin/bash
#FLUX: --job-name=Muframex
#FLUX: --queue=GPU
#FLUX: --urgency=16

nvidia-smi
cd $(pwd)
source /opt/anaconda3_titan/bin/activate
conda activate torch
hostname
python src/test.py
date
