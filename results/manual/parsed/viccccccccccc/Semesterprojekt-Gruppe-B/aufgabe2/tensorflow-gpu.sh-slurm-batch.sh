#!/bin/bash
#FLUX: --job-name=tensorflow-gpu
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load cuda
python versuch2.1.py
