#!/bin/bash
#FLUX: --job-name=RESNET101
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

echo "Date      = $(date)"
echo "host      = $(hostname -s)"
echo "Directory = $(pwd)"
module purge
ml pytorch/1.8.1
T1=$(date +%s)
python BYOL_SIIM-ISIC_RESNET101.py
T2=$(date +%s)
ELAPSED=$((T2 - T1))
echo "Elapsed Time = $ELAPSED"
