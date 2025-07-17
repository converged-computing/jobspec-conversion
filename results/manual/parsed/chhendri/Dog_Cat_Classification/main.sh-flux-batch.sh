#!/bin/bash
#FLUX: --job-name=project_ia
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load TensorFlow/2.3.1-fosscuda-2019b-Python-3.7.4
python3 main.py
