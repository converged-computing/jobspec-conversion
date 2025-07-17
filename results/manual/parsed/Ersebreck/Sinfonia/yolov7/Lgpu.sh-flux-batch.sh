#!/bin/bash
#FLUX: --job-name=frame_d
#FLUX: -n=10
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

echo "Soy un JOB de prueba en GPU"
nvidia-smi
python YoloRos.py
