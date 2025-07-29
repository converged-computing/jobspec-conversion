#!/bin/bash
#FLUX --job-name=buttery-fudge-2709
#FLUX --queue=gpu
#FLUX -t=18000
#FLUX --urgency=16

ml TensorFlow/1.10.1-fosscuda-2018a-Python-3.6.4
python -u acgan64.py
