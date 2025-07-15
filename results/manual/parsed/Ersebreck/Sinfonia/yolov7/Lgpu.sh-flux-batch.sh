#!/bin/bash
#FLUX: --job-name=frame_d
#FLUX: --urgency=16

echo "Soy un JOB de prueba en GPU"
nvidia-smi
python YoloRos.py
