#!/bin/bash
#FLUX: --job-name=astute-chip-0501
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --urgency=16

ml TensorFlow/1.10.1-fosscuda-2018a-Python-3.6.4
python -u acgan64.py
