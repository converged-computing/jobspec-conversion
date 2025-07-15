#!/bin/bash
#FLUX: --job-name=frame_d
#FLUX: --priority=16

echo "Soy un JOB de prueba en GPU"
nvidia-smi
python YoloRos.py
